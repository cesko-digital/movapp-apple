//
//  WordView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI


struct TranslationView: View {
    
    @EnvironmentObject var favoritesService: TranslationFavoritesService
    
    let language: SetLanguage
    @ObservedObject var translation: Translation
    let isOdd: Bool
    
    let translations: [String]
    let transcriptions: [String]
    let ttsLanguages: [String]
    
    let spacing: CGFloat = 10.0
    
    init (language: SetLanguage, translation: Translation, isOdd: Bool) {
        self.language = language
        self.isOdd = isOdd
        self.translation = translation
        
        var translations = [
            translation.translationFrom,
            translation.translationTo
        ]
        var transcriptions = [
            translation.transcriptionFrom,
            translation.transcriptionTo
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
        ZStack (alignment: .leading) {
            
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
            
            favoriteState
        }
    }
    
    var favoriteState: some View {
        let starSize = 30.0
        
        return Image(systemName: translation.isFavorited ? "star.fill" : "star")
            .foregroundColor(Color("colors/accent"))
            .frame(width: starSize, height: starSize)
            .background(Color("colors/background"))
            .cornerRadius(starSize / 2)
            .offset(x: starSize / -2, y: 0)
            .onTapGesture {
                favoritesService.setIsFavorited(!translation.isFavorited, translation: translation, language: language)
            }
    }
}

struct TranslationView_Previews: PreviewProvider {
    static let soundService = SoundService()
    static let favoritesService = TranslationFavoritesService()
    
    static var previews: some View {
        TranslationView(language: SetLanguage.csUk, translation: exampleTranslation, isOdd: true)
            .environmentObject(soundService)
            .environmentObject(favoritesService)
        
        TranslationView(language: SetLanguage.ukCs, translation: exampleTranslation, isOdd: false)
            .environmentObject(soundService)
            .environmentObject(favoritesService)
    }
}
