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
        translations: [Dictionary.Translation])
    {
        self.language = language
        
        if searchString.isEmpty {
            showTranslations = translations
        } else {
            showTranslations = TranslationMatchService.matchTranslations(translations, searchString: searchString, language: language)
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
    static let favoritesService = TranslationFavoritesService()
    
    static var previews: some View {
        TranslationsView(
            language: .csUk,
            searchString: "",
            translations: [
                exampleTranslation,
            ]
        )
        .environmentObject(soundService)
        .environmentObject(favoritesService)
        
        TranslationsView(
            language: .ukCs,
            searchString: "",
            translations: [
                exampleTranslation
            ]
        )
        .environmentObject(soundService)
        .environmentObject(favoritesService)
    }
}
