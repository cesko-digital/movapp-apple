//
//  TranslationView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import SwiftUI

struct TranslationView: View {

    let language: Languages
    let translation: Dictionary.Phrase.Translation

    func formatTranscription (_ string: String) -> String {
        return "[ \(string) ]"
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(translation.translation)
                    .foregroundColor(Color("colors/text"))
                    .textSelection(.enabled)
                    .font(.system(size: 20))

                Text(formatTranscription(translation.transcription))
                    .foregroundColor(Color("colors/secondary"))
                    .textSelection(.enabled)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

            PlayButtonView(soundFileName: translation.soundFileName)

        }.frame(maxWidth: .infinity)
    }
}

struct TranslationView_Previews: PreviewProvider {

    static let soundService = SoundService()

    static var previews: some View {
        TranslationView(
            language: Languages.cs,
            translation: examplePhrase.main
        ).environmentObject(soundService)

        TranslationView(
            language: Languages.uk,
            translation: examplePhrase.source
        ).environmentObject(soundService)
    }
}
