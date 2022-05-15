//
//  PhraseView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct PhraseView: View {
    
    struct DisplayableTranslation {
        let main: Dictionary.Phrase.Translation
        let source: Dictionary.Phrase.Translation
        let languageMain: Languages
        let languageSource: Languages
    }
    
    @EnvironmentObject var favoritesService: TranslationFavoritesService
    
    let language: SetLanguage
    let phrase: Dictionary.Phrase
    
    let displayableTranslation: DisplayableTranslation
    
    var isTranslationFavorited: Bool {
        favoritesService.isFavorited(phrase, language: language)
    }
    
    init (language: SetLanguage, phrase: Dictionary.Phrase) {
        self.language = language
        self.phrase = phrase
        
        let displayableTranslation = DisplayableTranslation(
            main: phrase.main,
            source: phrase.source,
            languageMain: language.language.main,
            languageSource: language.language.source
        )
        
        self.displayableTranslation = language.flipFromWithTo
        ? displayableTranslation.flipped
        : displayableTranslation
    }
    
    var body: some View {
        let spacing: CGFloat = 10.0
        
        ZStack (alignment: .leading) {
            
            VStack (alignment: .leading, spacing: spacing) {
                
                TranslationView(
                    language: displayableTranslation.languageMain,
                    translation: displayableTranslation.main
                )
                
                Rectangle()
                    .fill(Color("colors/inactive"))
                    .frame(height: 1)
                
                TranslationView(
                    language: displayableTranslation.languageSource,
                    translation: displayableTranslation.source
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
                favoritesService.setIsFavorited(!isTranslationFavorited, translationId: phrase.id, language: language)
            }
    }
}

extension PhraseView.DisplayableTranslation {
    
    var flipped: PhraseView.DisplayableTranslation {
        .init(
            main: source,
            source: main,
            languageMain: languageSource,
            languageSource: languageMain
        )
    }
}

struct PhraseView_Previews: PreviewProvider {
    static let soundService = SoundService()
    static let userDefaultsStore = UserDefaultsStore()
    static let favoritesService = TranslationFavoritesService(userDefaultsStore: userDefaultsStore, dictionaryDataStore: DictionaryDataStore())
    
    static var previews: some View {
        PhraseView(language: SetLanguage.csUk, phrase: examplePhrase)
            .padding()
            .previewDisplayName("csUk")
            .previewLayout(.sizeThatFits)
            .environmentObject(soundService)
            .environmentObject(favoritesService)
        
        PhraseView(language: SetLanguage.ukCs, phrase: examplePhrase)
            .padding()
            .previewDisplayName("ukCs")
            .previewLayout(.sizeThatFits)
            .environmentObject(soundService)
            .environmentObject(favoritesService)
    }
}
