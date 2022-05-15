//
//  PhrasesView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct PhrasesView: View {
    
    var showPhrases: [Dictionary.Phrase]
    let language: SetLanguage
    
    init (
        language: SetLanguage,
        searchString: String,
        translations: [Dictionary.Phrase],
        matchService: TranslationMatchService
    )
    {
        self.language = language
        
        if searchString.isEmpty {
            showPhrases = translations
        } else {
            showPhrases = matchService.matchTranslations(translations, searchString: searchString, language: language)
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(showPhrases)  { phrase in
                    PhraseView(
                        language: language,
                        phrase: phrase
                    )
                }
            }
            .padding()
            .background(Color("colors/background"))
        }
    }
}

struct PhrasesView_Previews: PreviewProvider {
    static let soundService = SoundService()
    static let userDefaultsStore = UserDefaultsStore()
    static let favoritesService = TranslationFavoritesService(userDefaultsStore: userDefaultsStore, dictionaryDataStore: DictionaryDataStore())
    static let matchService = TranslationMatchService(favoritesService: favoritesService)
    
    static var previews: some View {
        PhrasesView(
            language: .csUk,
            searchString: "",
            translations: [
                examplePhrase,
            ],
            matchService: matchService
        )
        .environmentObject(soundService)
        .environmentObject(favoritesService)
        
        PhrasesView(
            language: .ukCs,
            searchString: "",
            translations: [
                examplePhrase
            ],
            matchService: matchService
        )
        .environmentObject(soundService)
        .environmentObject(favoritesService)
    }
}
