//
//  PlayButtonView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 26.04.2022.
//

import SwiftUI

struct PlayButtonView: View {
    @EnvironmentObject var soundService: SoundService
    
    let id: String
    let inDirectory: String
    
    var body: some View {
        SoundStateButtonView(isPlaying: soundService.isPlaying(id: id)) {
            soundService.play(id, inDirectory: inDirectory)
        }
    }
}

struct PlayButtonView_Previews: PreviewProvider {
    static let soundService = SoundService()
    
    static var previews: some View {
        PlayButtonView(id: AlphabetItem.example.id, inDirectory: "data/cs-alphabet")
            .padding()
            .environmentObject(soundService)
            .previewLayout(.sizeThatFits)
    }
}
