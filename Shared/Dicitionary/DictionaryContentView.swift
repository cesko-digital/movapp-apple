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
     We want to setup same size for picker / category header to prevent any scroll view movements while
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
    let categories: [Dictionary.Category]
    let phrases: [Dictionary.PhraseID: Dictionary.Phrase]
    let categoryPhrases: Array<Dictionary.Phrase>?
    
    @EnvironmentObject var favoritesProvider: PhrasesFavoritesProvider
   
    @Binding var selectedCategory: Dictionary.Category?
    @State private var view: DictionaryContentSubView = .dictionary;
    
    init(
        searchString: String,
        language: SetLanguage,
        categories: [Dictionary.Category],
        phrases: [Dictionary.PhraseID: Dictionary.Phrase],
        selectedCategory: Binding<Dictionary.Category?>
    ) {
        self.searchString = searchString
        self.language = language
        self.categories = categories
        self.phrases = phrases
        self._selectedCategory = selectedCategory
        
        // Optimize the view
        if let selected = selectedCategory.wrappedValue {
            categoryPhrases = phrases.filter(identifiers: selected.phrases)
        } else {
            categoryPhrases = nil
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // If category is selected show phases
            if selectedCategory != nil {
                AccordionHeaderView(language: language, selectedCategory: $selectedCategory)
                    .styleSubHeaderContent()
                
            } else {
                Picker("Select phrases", selection: $view) {
                    Text("Dictionary", comment: "Dictionary list").tag(DictionaryContentSubView.dictionary)
                    Text("Favorites", comment: "Favorites list").tag(DictionaryContentSubView.favorites)
                }
                .pickerStyle(.segmented)
                .styleSubHeaderContent()
            }
            
            if view == .dictionary && searchString == "" && selectedCategory == nil {
                AccordionsView(
                    language: language,
                    categories: categories,
                    selectedCategory: $selectedCategory
                )
            } else {
                phrasesView
            }
        }
    }
    
    var phrasesView: some View {
        
        let visiblePhrases: [Dictionary.Phrase]
        
        switch (view) {
        case .dictionary:
            visiblePhrases = categoryPhrases ?? Array(phrases.values)
        case .favorites:
            visiblePhrases = phrases.filter(identifiers: favoritesProvider.getFavorites(language: language))
        }
        
        return PhrasesView(
            language: language,
            searchString: searchString,
            phrases: visiblePhrases,
            matchService: PhraseMatchService(favoritesService: self.favoritesProvider.favoritesService)
        )
    }
    
}

struct DictionaryContentView_Previews: PreviewProvider {
    
    static let soundService = SoundService()
    static let userDefaultsStore = UserDefaultsStore()
    static let favoritesService = PhraseFavoritesService(userDefaultsStore: userDefaultsStore, dictionaryDataStore: DictionaryDataStore())
    static let favoritesProvider = PhrasesFavoritesProvider(favoritesService: favoritesService)
    
    static let phrases: [Dictionary.PhraseID: Dictionary.Phrase] = [
        examplePhrase.id: examplePhrase
    ]
    
    static var previews: some View {
        DictionaryContentView(
            searchString: "",
            language: SetLanguage.csUk,
            categories: [exampleCategory],
            phrases: phrases,
            selectedCategory: .constant(nil)
        )
        .environmentObject(soundService)
        .environmentObject(favoritesService)
        .environmentObject(favoritesProvider)
        
        DictionaryContentView(
            searchString: "",
            language: SetLanguage.ukCs,
            categories: [exampleCategory, exampleCategory],
            phrases: phrases,
            selectedCategory: .constant(exampleCategory)
        )
        .environmentObject(soundService)
        .environmentObject(favoritesService)
        .environmentObject(favoritesProvider)
    }
}
