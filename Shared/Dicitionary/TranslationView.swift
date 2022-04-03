//
//  WordView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI


struct TranslationView: View {
  
    let language: Language
    let translations: [String]
    let transcriptions: [String]
    
    let spacing: CGFloat = 10.0
    
    init (language: Language, translation: Translation) {
        self.language = language
        
        var translations = [
            translation.translation_from,
            translation.translation_to
        ]
        var transcriptions = [
            translation.transcription_from,
            translation.transcription_to
        ]
        
        if language.flipFromWithTo {
            translations = translations.reversed()
            transcriptions = transcriptions.reversed()
        }
        
        self.translations = translations
        self.transcriptions = transcriptions
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: spacing) {
            
            WordView(language: language, text: translations.first!, transcription: transcriptions.first!)
            
            Rectangle()
                .fill(Color("colors/inactive"))
                .frame(height: 1)
            
            WordView(language: language, text: translations.last!, transcription: transcriptions.last!)
        }
        .padding(.horizontal, spacing * 2)
        .padding(.vertical, spacing)
        .frame(maxWidth: .infinity)
        .background(Color("colors/item"))
        .cornerRadius(13)
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView(language: .csUk, translation: exampleTranslation)
        TranslationView(language: .ukCs, translation: exampleTranslation)
    }
}
