//
//  WordsView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct TranslationsView: View {
    var showTranslations: [Translation]
    let language: SetLanguage
    
    init (
        language: SetLanguage,
        searchString: String,
        translations: [Translation])
    {
        self.language = language
        
        if searchString.isEmpty {
            showTranslations = translations
        } else {
            showTranslations = TranslationMatchService.matchTranslations(translations, searchString: searchString)
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(Array(showTranslations.enumerated()), id: \.0)  { index, translation in
                    let isOdd = (index % 2) != 0
                    
                    TranslationView(
                        language: language,
                        translation: translation,
                        isOdd: isOdd
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
    
    static var previews: some View {
        TranslationsView(
            language: .csUk,
            searchString: "",
            translations: [
                exampleTranslation
            ]
        )
        .environmentObject(soundService)
        
        TranslationsView(
            language: .ukCs,
            searchString: "",
            translations: [
                exampleTranslation
            ]
        )
        .environmentObject(soundService)
    }
}
