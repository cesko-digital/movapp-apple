//
//  SoundService.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import Foundation
import AVFoundation
import UIKit

struct Playback {
    let soundFileName: String
}

final class SoundService: NSObject, ObservableObject {

    private var player: AVAudioPlayer?

    var playbackPipe: [Playback] = []

    @Published var isPlaying: Bool = false

    private var sessionCategory: AVAudioSession.Category?

    override init() {
        super.init()
    }

    private func getCurrentPlayback() -> Playback? {
        return playbackPipe.first
    }

    func isPlaying(path: String?) -> Bool {
        guard let path = path else {
            print("nil cannot be played.")
            return false
        }

        return getCurrentPlayback()?.soundFileName == path
    }

    func play(path: String?) {
        guard let path = path else {
            print("nil cannot be played.")
            return
        }

        playbackPipe.append(Playback(soundFileName: path))

        stopAndPlayNext()
    }

    private func tryToPlayNext () {
        guard let currentPlayback = getCurrentPlayback() else {
            return
        }

        playSound(currentPlayback.soundFileName)
    }

    private func playSound(_ assetName: String) {
        guard let data = NSDataAsset(name: assetName) else {
            print("File does not exists \(assetName)")
            return
        }

        do {
            let player = try AVAudioPlayer(data: data.data)
            self.player = player

            player.delegate = self
            player.play()

            on()

        } catch {
            print("Failed to play \(assetName) - \(error.localizedDescription)")
        }
    }

    private func stopAndPlayNext () {
        if isPlaying == false {
            tryToPlayNext()
            return
        }

        if let player = self.player {
            player.stop()
            off() // Sound is not triggering delegate event.
        }
    }

    private func on () {
        isPlaying = true
        sessionCategory = AVAudioSession.sharedInstance().category
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    }

    private func off () {
        guard playbackPipe.isEmpty == false else {
            return
        }

        playbackPipe.remove(at: 0)

        // Trigger change
        isPlaying = false

        if let sessionCategory = sessionCategory {
            try? AVAudioSession.sharedInstance().setCategory(sessionCategory)
        }
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)

        tryToPlayNext()
    }
}

extension SoundService: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Audio player has finished")
        off()
    }

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Error while playing \(error?.localizedDescription ?? "")")
        off()
    }
}
