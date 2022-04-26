//
//  SpeakButtonView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 26.04.2022.
//

import SwiftUI

struct SpeakButtonView: View {
    @EnvironmentObject var soundService: SoundService
    
    let language: Languages
    let text: String
    
    var body: some View {
        SoundStateButtonView(isPlaying: soundService.isSpeaking(text: text)) {
            soundService.speach(language: language, text: text)
        }
    }
}

struct SpeakButtonView_Previews: PreviewProvider {
    static let soundService = SoundService()
    
    static var previews: some View {
        SpeakButtonView(language: .cs, text: "Ahoj")
            .padding()
            .environmentObject(soundService)
            .previewLayout(.sizeThatFits)
    }
}
