//
//  WordView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct TranslationView: View {
    
    struct DisplayableTranslation {
        let translationFrom: String
        let translationTo: String
        let transcriptionFrom: String
        let transcriptionTo: String
        let ttsLanguageFrom: Languages
        let ttsLanguageTo: Languages
    }
    
    @EnvironmentObject var favoritesService: TranslationFavoritesService
    
    let language: SetLanguage
    let translation: Dictionary.Translation
    
    let displayableTranslation: DisplayableTranslation
    
    var isTranslationFavorited: Bool {
        favoritesService.isFavorited(translation, language: language)
    }
    
    init (language: SetLanguage, translation: Dictionary.Translation) {
        self.language = language
        self.translation = translation
        
        let displayableTranslation = DisplayableTranslation(
            translationFrom: translation.main.translation,
            translationTo: translation.source.translation,
            transcriptionFrom: translation.main.transcription,
            transcriptionTo: translation.source.transcription,
            ttsLanguageFrom: language.language.main,
            ttsLanguageTo: language.language.source
        )
        
        self.displayableTranslation = language.flipFromWithTo
            ? displayableTranslation.flipped
            : displayableTranslation
    }
    
    var body: some View {
        let spacing: CGFloat = 10.0
        
        ZStack (alignment: .leading) {
            
            VStack (alignment: .leading, spacing: spacing) {
                
                WordView(
                    language: displayableTranslation.ttsLanguageFrom,
                    text: displayableTranslation.translationFrom,
                    transcription: displayableTranslation.transcriptionFrom
                )
                
                Rectangle()
                    .fill(Color("colors/inactive"))
                    .frame(height: 1)
                
                WordView(
                    language: displayableTranslation.ttsLanguageTo,
                    text: displayableTranslation.translationTo,
                    transcription: displayableTranslation.transcriptionTo
                )
            }
            .padding(.horizontal, spacing * 2)
            .padding(.vertical, spacing)
            .frame(maxWidth: .infinity)
            .background(Color("colors/item"))
            .cornerRadius(13)
            
            favoriteState
        }
    }
    
    var favoriteState: some View {
        let starSize = 30.0
        
        return Image(systemName: isTranslationFavorited ? "star.fill" : "star")
            .foregroundColor(Color("colors/primary"))
            .frame(width: starSize, height: starSize)
            .background(Color("colors/background"))
            .cornerRadius(starSize / 2)
            .offset(x: starSize / -2, y: 0)
            .onTapGesture {
                favoritesService.setIsFavorited(!isTranslationFavorited, translationId: translation.id, language: language)
            }
    }
}

extension TranslationView.DisplayableTranslation {
    
    var flipped: TranslationView.DisplayableTranslation {
        .init(
            translationFrom: translationTo,
            translationTo: translationFrom,
            transcriptionFrom: transcriptionTo,
            transcriptionTo: transcriptionFrom,
            ttsLanguageFrom: ttsLanguageTo,
            ttsLanguageTo: ttsLanguageFrom
        )
    }
}

struct TranslationView_Previews: PreviewProvider {
    static let soundService = SoundService()
    static let userDefaultsStore = UserDefaultsStore()
    static let favoritesService = TranslationFavoritesService(userDefaultsStore: userDefaultsStore, dictionaryDataStore: DictionaryDataStore())
    
    static var previews: some View {
        TranslationView(language: SetLanguage.csUk, translation: exampleTranslation)
            .padding()
            .previewDisplayName("csUk")
            .previewLayout(.sizeThatFits)
            .environmentObject(soundService)
            .environmentObject(favoritesService)
        
        TranslationView(language: SetLanguage.ukCs, translation: exampleTranslation)
            .padding()
            .previewDisplayName("ukCs")
            .previewLayout(.sizeThatFits)
            .environmentObject(soundService)
            .environmentObject(favoritesService)
    }
}
