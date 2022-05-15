//
//  DictionaryContentView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import SwiftUI

enum DictionaryContentSubView: Equatable {
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
    let sections: [Dictionary.Category]
    let translations: [Dictionary.TranslationID: Dictionary.Phrase]
    let sectionTranslations: Array<Dictionary.Phrase>?
    
    @EnvironmentObject var favoritesProvider: TranslationFavoritesProvider
   
    @Binding var selectedSection: Dictionary.Category?
    @State private var view: DictionaryContentSubView = .dictionary;
    
    init(
        searchString: String,
        language: SetLanguage,
        sections: [Dictionary.Category],
        translations: [Dictionary.TranslationID: Dictionary.Phrase],
        selectedSection: Binding<Dictionary.Category?>
    ) {
        self.searchString = searchString
        self.language = language
        self.sections = sections
        self.translations = translations
        self._selectedSection = selectedSection
        
        // Optimize the view
        if let selectedSection = selectedSection.wrappedValue {
            sectionTranslations = translations.filter(identifiers: selectedSection.phrases)
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
                Picker("Select phrases", selection: $view) {
                    Text("Dictionary", comment: "Dictionary list").tag(DictionaryContentSubView.dictionary)
                    Text("Favorites", comment: "Favorites list").tag(DictionaryContentSubView.favorites)
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
        
        let visibleTranslations: [Dictionary.Phrase]
        
        switch (view) {
        case .dictionary:
            visibleTranslations = sectionTranslations ?? Array(translations.values)
        case .favorites:
            visibleTranslations = translations.filter(identifiers: favoritesProvider.getFavorites(language: language))
        }
        
        return PhrasesView(
            language: language,
            searchString: searchString,
            translations: visibleTranslations,
            matchService: TranslationMatchService(favoritesService: self.favoritesProvider.favoritesService)
        )
    }
    
}

struct DictionaryContentView_Previews: PreviewProvider {
    
    static let soundService = SoundService()
    static let userDefaultsStore = UserDefaultsStore()
    static let favoritesService = TranslationFavoritesService(userDefaultsStore: userDefaultsStore, dictionaryDataStore: DictionaryDataStore())
    static let favoritesProvider = TranslationFavoritesProvider(favoritesService: favoritesService)
    
    static let translations: [Dictionary.TranslationID: Dictionary.Phrase] = [
        examplePhrase.id: examplePhrase
    ]
    
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
        .environmentObject(favoritesProvider)
        
        DictionaryContentView(
            searchString: "",
            language: SetLanguage.ukCs,
            sections: [exampleSection, exampleSection],
            translations: translations,
            selectedSection: .constant(exampleSection)
        )
        .environmentObject(soundService)
        .environmentObject(favoritesService)
        .environmentObject(favoritesProvider)
    }
}
