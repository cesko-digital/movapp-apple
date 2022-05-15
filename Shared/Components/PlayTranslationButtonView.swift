//
//  PlayTranslationButtonView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 15.05.2022.
//

import SwiftUI

struct PlayTranslationButtonView: View {
    @EnvironmentObject var soundService: SoundService
    
    let language: Languages
    let translation: Dictionary.Phrase.Translation
    
    var body: some View {
        if soundService.canPlayTranslation(language: language, translation: translation) {
            SoundStateButtonView(isPlaying: soundService.isPlaying(translation: translation)) {
                soundService.playTranslation(language: language, translation: translation)
            }
        }
    }
}

struct PlayTranslationButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        PlayTranslationButtonView(language: .cs, translation: examplePhrase.main)
            .environmentObject(SoundService())
    }
}
