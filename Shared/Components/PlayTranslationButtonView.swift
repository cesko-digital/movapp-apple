//
//  PlayTranslationButtonView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 15.05.2022.
//

import SwiftUI

struct PlayTranslationButtonView: View {
    @EnvironmentObject var soundService: SoundService

    let translation: Dictionary.Phrase.Translation

    var body: some View {
        if let soundFileName = translation.soundFileName {
            SoundStateButtonView(isPlaying: soundService.isPlaying(path: soundFileName)) {
                soundService.play(path: soundFileName)
            }
        }
    }
}

struct PlayTranslationButtonView_Previews: PreviewProvider {

    static var previews: some View {
        PlayTranslationButtonView(translation: examplePhrase.main)
            .environmentObject(SoundService())
    }
}
