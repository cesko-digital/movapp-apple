//
//  WordsView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct TranslationsView: View {
    
    var showTranslations: [Dictionary.Translation]
    let language: SetLanguage
    
    init (
        language: SetLanguage,
        searchString: String,
        translations: [Dictionary.Translation],
        matchService: TranslationMatchService
    )
    {
        self.language = language
        
        if searchString.isEmpty {
            showTranslations = translations
        } else {
            showTranslations = matchService.matchTranslations(translations, searchString: searchString, language: language)
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(showTranslations)  { translation in
                    TranslationView(
                        language: language,
                        translation: translation
                    )
                }
            }
            .padding()
            .background(Color("colors/background"))
        }
    }
}

struct TranslationsView_Previews: PreviewProvider {
    static let soundService = SoundService()
    static let userDefaultsStore = UserDefaultsStore()
    static let favoritesService = TranslationFavoritesService(userDefaultsStore: userDefaultsStore, dictionaryDataStore: DictionaryDataStore())
    static let matchService = TranslationMatchService(favoritesService: favoritesService)
    
    static var previews: some View {
        TranslationsView(
            language: .csUk,
            searchString: "",
            translations: [
                exampleTranslation,
            ],
            matchService: matchService
        )
        .environmentObject(soundService)
        .environmentObject(favoritesService)
        
        TranslationsView(
            language: .ukCs,
            searchString: "",
            translations: [
                exampleTranslation
            ],
            matchService: matchService
        )
        .environmentObject(soundService)
        .environmentObject(favoritesService)
    }
}
