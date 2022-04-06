//
//  DictionaryContentView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import SwiftUI

enum DictionaryContentSubView: Int {
    case dictionary
    case favorites
}


extension View {
    /**
     We want to setup same size for picker / section header to prevent any scroll view movements while
     animating.
     */
    func styleSubHeaderContent () -> some View {
        self.padding(.horizontal)
            .frame(height: 50)
    }
}

struct DictionaryContentView: View {
    let searchString: String
    let language: SetLanguage
    let sections: Sections
    let translations: Translations
    let sectionTranslations: Array<Translation>?
    
    @EnvironmentObject var favoritesService: TranslationFavoritesService
    
    @Binding var selectedSection: Section?
    @State private var view: DictionaryContentSubView = .dictionary;
    
    init(
        searchString: String,
        language: SetLanguage,
        sections: Sections,
        translations: Translations,
        selectedSection: Binding<Section?>
    ) {
        self.searchString = searchString
        self.language = language
        self.sections = sections
        self.translations = translations
        self._selectedSection = selectedSection
        
        // Optimize the view
        if selectedSection.wrappedValue != nil {
            var translations : [Translation] = []
            
            for translationId in selectedSection.wrappedValue!.translations {
                guard let translation = self.translations.byId[translationId] else {
                    continue
                }
                
                translations.append(translation)
            }
            
            sectionTranslations = translations
        } else {
            sectionTranslations = nil
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // If section is selected show translations
            if selectedSection != nil {
                AccordionHeaderView(language: language, selectedSection: $selectedSection)
                    .styleSubHeaderContent()
                
            } else {
                Picker("Select view", selection: $view) {
                    Text("Dictionary").tag(DictionaryContentSubView.dictionary)
                    Text("Favorites").tag(DictionaryContentSubView.favorites)
                }
                .pickerStyle(.segmented)
                .styleSubHeaderContent()
            }
            
            if view == .dictionary && searchString == "" && selectedSection == nil {
                AccordionsView(
                    language: language,
                    sections: sections,
                    selectedSection: $selectedSection
                )
            } else {
                translationsView
            }
        }
    }
    
    
    var translationsView: some View {
        
        let visibleTranslations: [Translation]
        
        switch (view) {
        case .dictionary:
            visibleTranslations = sectionTranslations ?? Array(translations.byId.values)
        case .favorites:
            let favoritesIds = favoritesService.getFavorites(language: language)
            
            var translations: [Translation] = []
            for favoriteId in favoritesIds {
                guard let translation = self.translations.byId[favoriteId] else {
                    continue
                }
                
                translations.append(translation)
            }
            
            visibleTranslations = translations
        }
        
        return TranslationsView(
            language: language,
            searchString: searchString,
            translations: visibleTranslations
        )
    }
    
}

struct DictionaryContentView_Previews: PreviewProvider {
    
    static let soundService = SoundService()
    static let favoritesService = TranslationFavoritesService()
    
    static let translations: Translations = Translations(byId: [
        "d6e710c7f44b67220cd9b870e6107bf9": exampleTranslation
    ])
    
    static var previews: some View {
        DictionaryContentView(
            searchString: "",
            language: SetLanguage.csUk,
            sections: [exampleSection],
            translations: translations,
            selectedSection: .constant(nil)
        )
        .environmentObject(soundService)
        .environmentObject(favoritesService)
        
        DictionaryContentView(
            searchString: "",
            language: SetLanguage.ukCs,
            sections: [exampleSection, exampleSection],
            translations: translations,
            selectedSection: .constant(exampleSection)
        )
        .environmentObject(soundService)
        .environmentObject(favoritesService)
    }
}
