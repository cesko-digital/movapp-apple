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
    let soundIdOrText: String
    let languageOrDirectory: String
}

class SoundService: NSObject, ObservableObject {

    var player: AVAudioPlayer? = nil
    
    var playbackPipe: [Playback] = []
    
    @Published var isPlaying: Bool = false
    
    
    override init() {
        super.init()
    }
    
    func getCurrentPlayback() -> Playback? {
        return playbackPipe.first
    }
    
    func isPlaying(id: String) -> Bool {
        guard let currentPlayback = getCurrentPlayback() else {
            return false
        }
        
        return currentPlayback.soundIdOrText.compare(id) == .orderedSame
    }
    
    func isPlaying(translation: Dictionary.Phrase.Translation) -> Bool {
        if let soundFileName = translation.soundFileName, isPlaying(id: soundFileName) {
            return true
        }
        
        return false
    }

    func canPlayTranslation(language: Languages, translation: Dictionary.Phrase.Translation) -> Bool {
        if translation.soundFileName != nil {
            return true
        } else {
            return false
        }
    }
    
    
    func playTranslation(language: Languages, translation: Dictionary.Phrase.Translation) {
        
        if isPlaying(translation: translation) {
            stopAndPlayNext()
            return
        }
        
        if let soundFileName = translation.soundFileName {
            play(soundFileName, inDirectory: "data/\(language.rawValue)-sounds")
        } else {
            print("Cant play sound, missing sound or un-suported language", language, translation)
        }
    }
    
    /**
     Plays given sound in assets (only for small sizes)
     */
    func play (_ id: String, inDirectory: String) {
        playbackPipe.append(Playback(soundIdOrText: id, languageOrDirectory: inDirectory))
        
        stopAndPlayNext()
    }
    
    
    // https://developer.apple.com/documentation/avfoundation/speech_synthesis#overview
//    private func speach(language: Languages, text: String) {
//        playbackPipe.append(Playback(type: .speaking, soundIdOrText: text, languageOrDirectory: language.rawValue))
//
//        stopAndPlayNext()
//    }
    
    private func tryToPlayNext () {
        guard let currentPlayback = getCurrentPlayback() else {
            return
        }

        playSound(currentPlayback.soundIdOrText, inDirectory: currentPlayback.languageOrDirectory)
    }

    
    private func playSound(_ id: String, inDirectory: String) {
        let assetName = "\(inDirectory)/\(id)"
        
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
            print("Failed to play \(id) - \(error.localizedDescription)")
        }
    }
    
    func stopAndPlayNext () {
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
        try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    }
    
    private func off () {
        guard playbackPipe.isEmpty == false else {
            return
        }
        
        playbackPipe.remove(at: 0)
        
        // Trigger change
        isPlaying = false
        
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
