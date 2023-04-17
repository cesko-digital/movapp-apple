//
//  PlayButtonView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 26.04.2022.
//

import SwiftUI

struct PlayButtonView: View {
    @EnvironmentObject var soundService: SoundService

    let soundFileName: String?

    var body: some View {
        if let soundFileName = soundFileName {
            SoundStateButtonView(isPlaying: soundService.isPlaying(path: soundFileName)) {
                soundService.play(path: soundFileName)
            }
        }
    }
}

struct PlayButtonView_Previews: PreviewProvider {
    static let soundService = SoundService()

    static var previews: some View {
        PlayButtonView(soundFileName: "data/cs-alphabet/\(AlphabetItem.example.id)")
            .padding()
            .environmentObject(soundService)
            .previewLayout(.sizeThatFits)
    }
}
