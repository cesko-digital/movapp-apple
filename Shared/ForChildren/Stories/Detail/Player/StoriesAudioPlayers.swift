//
//  StoriesAudioPlayers.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 21.11.2022.
//

import Foundation

class StoriesAudioPlayers {

    private let mainPlayer: StoryAudioPlayer
    private let secondPlayer: StoryAudioPlayer

    private var currentPlayer: StoryAudioPlayer

    var duration: TimeInterval {
        currentPlayer.duration
    }

    var currentTime: TimeInterval {
        currentPlayer.currentTime
    }

    var isPlaying: Bool {
        currentPlayer.isPlaying
    }

    init(slug: String, main: Languages, second: Languages) throws {
        mainPlayer = try StoryAudioPlayer(suffix: "\(slug)/\(main.rawValue)")
        secondPlayer = try StoryAudioPlayer(suffix: "\(slug)/\(second.rawValue)")

        self.currentPlayer = mainPlayer
    }

    func switchLanguage() {
        if currentPlayer == mainPlayer {
            currentPlayer = secondPlayer
        } else {
            currentPlayer = mainPlayer
        }
    }

    func play() {
        currentPlayer.play()
    }

    func pause() {
        currentPlayer.pause()
    }

    func stop() {
        currentPlayer.stop()
    }

    func forward() {
        currentPlayer.forward()
    }

    func backward() {
        currentPlayer.backward()
    }
}
