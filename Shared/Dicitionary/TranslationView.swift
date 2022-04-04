//
//  WordView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI


struct TranslationView: View {
  
    let isOdd: Bool
    let language: SetLanguage
    let translations: [String]
    let transcriptions: [String]
    let ttsLanguages: [String]
    
    let spacing: CGFloat = 10.0
    
    init (language: SetLanguage, translation: Translation, isOdd: Bool) {
        self.language = language
        self.isOdd = isOdd
        
        var translations = [
            translation.translation_from,
            translation.translation_to
        ]
        var transcriptions = [
            translation.transcription_from,
            translation.transcription_to
        ]
        var ttsLanguages = [
            language.language.from,
            language.language.to,
        ]
        
        if language.flipFromWithTo {
            translations = translations.reversed()
            transcriptions = transcriptions.reversed()
            ttsLanguages = ttsLanguages.reversed()
        }
        
        self.translations = translations
        self.transcriptions = transcriptions
        self.ttsLanguages = ttsLanguages
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: spacing) {
            
            WordView(language: ttsLanguages.first!, text: translations.first!, transcription: transcriptions.first!)
            
            Rectangle()
                .fill(Color("colors/inactive"))
                .frame(height: 1)
            
            WordView(language: ttsLanguages.last!, text: translations.last!, transcription: transcriptions.last!)
        }
        .padding(.horizontal, spacing * 2)
        .padding(.vertical, spacing)
        .frame(maxWidth: .infinity)
        .background(isOdd ? .clear : Color("colors/item"))
        .cornerRadius(13)
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView(language: SetLanguage.csUk, translation: exampleTranslation, isOdd: true)
        TranslationView(language: SetLanguage.ukCs, translation: exampleTranslation, isOdd: false)
    }
}
