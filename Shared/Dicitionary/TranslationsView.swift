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
    
    func shouldShowTranslation(
        searchString: String,
        strings: [String]
    ) -> Bool {
        for string in strings {
            if string.localizedCaseInsensitiveContains(searchString) {
                return true
            }
        }
        
        return false
    }
    
    init (
        language: SetLanguage,
        searchString: String,
        translations: [Translation])
    {
        self.language = language
        
        if searchString.isEmpty {
            showTranslations = translations
        } else {
            showTranslations = []
            
            for translation in translations {
                if shouldShowTranslation(searchString: searchString, strings: [
                        translation.translation_from,
                        translation.transcription_from,
                        translation.transcription_to,
                        translation.translation_to
                    ]) {
                    showTranslations.append(translation)
                }
            }
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(Array(showTranslations.enumerated()), id: \.0)  { index, translation in
                    let isOdd = (index % 2) != 0
                    TranslationView(language: language, translation: translation, isOdd: isOdd)
                }
            }
            .padding()
            .background(Color("colors/background"))
        }
    }
}

struct TranslationsView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationsView(
            language: .csUk,
            searchString: "",
            translations: [
                exampleTranslation
            ]
        )
        
        TranslationsView(
            language: .ukCs,
            searchString: "",
            translations: [
                exampleTranslation
            ]
        )
    }
}
