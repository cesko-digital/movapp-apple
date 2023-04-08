//
//  PhraseView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct PhraseView: View {

    struct DisplayablePhrase {
        let main: Dictionary.Phrase.Translation
        let source: Dictionary.Phrase.Translation
        let languageMain: Languages
        let languageSource: Languages
    }

    @EnvironmentObject var favoritesService: PhraseFavoritesService
    @Environment(\.horizontalSizeClass) var sizeClass

    let language: SetLanguage
    let phrase: Dictionary.Phrase

    let displayablePhrase: DisplayablePhrase

    var isPhraseFavorited: Bool {
        favoritesService.isFavorited(phrase, language: language)
    }

    init (language: SetLanguage, phrase: Dictionary.Phrase) {
        self.language = language
        self.phrase = phrase

        let displayablePhrase = DisplayablePhrase(
            main: phrase.main,
            source: phrase.source,
            languageMain: language.language.main,
            languageSource: language.language.source
        )

        self.displayablePhrase = language.flipFromWithTo
        ? displayablePhrase.flipped
        : displayablePhrase
    }

    var body: some View {
        let spacing: CGFloat = 10.0

        ZStack(alignment: .leading) {

            AdaptiveStack(horizontalAlignment: .leading, verticalAlignment: .top, spacing: spacing) {

                TranslationView(
                    language: displayablePhrase.languageMain,
                    translation: displayablePhrase.main
                )

                if sizeClass == .compact {
                    Rectangle()
                        .fill(Color("colors/inactive"))
                        .frame(height: 1)
                } else {
                    Spacer()
                    Rectangle()
                        .fill(Color("colors/inactive"))
                        .frame(width: 1)
                    Spacer()
                }

                TranslationView(
                    language: displayablePhrase.languageSource,
                    translation: displayablePhrase.source
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

        return Image(systemName: isPhraseFavorited ? "star.fill" : "star")
            .foregroundColor(Color("colors/primary"))
            .frame(width: starSize, height: starSize)
            .background(Color("colors/background"))
            .cornerRadius(starSize / 2)
            .offset(x: starSize / -2, y: 0)
            .onTapGesture {
                favoritesService.setIsFavorited(!isPhraseFavorited, translationId: phrase.id, language: language)
            }
    }
}

extension PhraseView.DisplayablePhrase {

    var flipped: PhraseView.DisplayablePhrase {
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
    static let favoritesService = PhraseFavoritesService(userDefaultsStore: userDefaultsStore,
                                                         dictionaryDataStore: DictionaryDataStore())

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
