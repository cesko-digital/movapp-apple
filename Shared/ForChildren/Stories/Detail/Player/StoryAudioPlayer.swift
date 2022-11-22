//
//  StoryAudioPlayer.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 21.11.2022.
//

import AVFAudio
import UIKit

class StoryAudioPlayer: Equatable {

    private let seekingStep: TimeInterval = 10

    private let avPlayer: AVAudioPlayer
    private var observer: NSKeyValueObservation?
    private var sessionCategory: AVAudioSession.Category?

    var duration: TimeInterval {
        avPlayer.duration
    }

    var currentTime: TimeInterval {
        avPlayer.currentTime
    }

    var isPlaying: Bool {
        avPlayer.isPlaying
    }

    // MARK: - Initializer

    init(suffix: String) throws {
        guard let data = NSDataAsset(name: "data/stories/\(suffix)") else {
            throw AudioError(message: "File does not exists \(suffix)")
        }

        avPlayer = try AVAudioPlayer(data: data.data)
    }

    // MARK: - Functions

    func play() {
        sessionCategory = AVAudioSession.sharedInstance().category
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)

        avPlayer.play()
    }

    func pause() {
        if let sessionCategory = sessionCategory {
            try? AVAudioSession.sharedInstance().setCategory(sessionCategory)
        }

        avPlayer.pause()
    }

    func stop() {
        avPlayer.stop()
    }

    func forward() {
        if avPlayer.currentTime + seekingStep > avPlayer.duration {
            avPlayer.currentTime = avPlayer.duration
        } else {
            avPlayer.currentTime += seekingStep
        }
    }

    func backward() {
        if avPlayer.currentTime < seekingStep {
            avPlayer.currentTime = 0
        } else {
            avPlayer.currentTime -= 10
        }
    }

    static func == (lhs: StoryAudioPlayer, rhs: StoryAudioPlayer) -> Bool {
        lhs.avPlayer == rhs.avPlayer
    }
}
