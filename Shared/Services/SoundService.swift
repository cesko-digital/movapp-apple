//
//  SoundService.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import Foundation
import AVFoundation
import UIKit

class SoundService: NSObject, ObservableObject {
    
    // Create a speech synthesizer.
    let synthesizer = AVSpeechSynthesizer()
    var player: AVAudioPlayer? = nil
    
    @Published var isPlaying: Bool = false
    
    var isSpeaking = false
    private var isSpeakingText: String?
    
    var isPlayingSound = false
    private var isPlayingSoundId: String?
    
    override init () {
        super.init()
        synthesizer.delegate = self
    }
    
    func isPlaying (id: String) -> Bool {
        return isPlayingSoundId?.compare(id) == .orderedSame
    }
    
    func isSpeaking (text: String) -> Bool {
        return isSpeakingText?.compare(text) == .orderedSame
    }
    
    
    /**
     Plays given sound in assets (only for small sizes)
     */
    func play (_ id: String, inDirectory: String) {
        stop()
        
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
            
            isPlayingSound = true
            isPlayingSoundId = id
            
            on()
            
        } catch {
            print("Failed to play \(id) - \(error.localizedDescription)")
        }
    }
    
    // https://developer.apple.com/documentation/avfoundation/speech_synthesis#overview
    func speach(language: Languages, text: String) {
        stop()
        
        // Create an utterance.
        let utterance = AVSpeechUtterance(string: text)
        
        let voice = AVSpeechSynthesisVoice(language: language.rawValue)
        
        // Assign the voice to the utterance.
        utterance.voice = voice
        
        isSpeakingText = text
        
        // Tell the synthesizer to speak the utterance.
        synthesizer.speak(utterance)
    }
    
    func stop () {
        if isPlaying == false {
            return
        }
        
        if isSpeaking == true {
            self.synthesizer.stopSpeaking(at: .immediate)
        }
        
        if isPlayingSound == true, let player = self.player {
            player.stop()
        }
    }
    
    private func on () {
        isPlaying = true
        try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    }
    
    private func off () {
        isSpeaking = false
        isPlayingSound = false
        
        isSpeakingText = nil
        isPlayingSoundId = nil
        
        // Trigger change
        isPlaying = false
        
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
}

extension SoundService: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        isSpeaking = true
        on()
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        off()
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        off()
    }
}

extension SoundService: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        off()
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Error while playing \(error?.localizedDescription ?? "")")
        off()
    }
}
