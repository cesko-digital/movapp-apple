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
    var isPlayingSound = false
    
    override init () {
        super.init()
        synthesizer.delegate = self
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
            on()
            
        } catch {
            print("Failed to play \(id) - \(error.localizedDescription)")
        }
    }
    
    /**
     Plays given sound and expects a file name with extension to correctly find it in bundle.
     **NOT working!**
     */
    func playNotWorking (_ fileName: String, inDirectory: String) {
        stop()
        
        let splitted = fileName.split(separator: ".")
        
        if splitted.count != 2 {
            print("Invalid file - no extension \(fileName)")
            return
        }
        
        let file = String(splitted.first!)
        let fileExtension = String(splitted.last!)
        
        guard let path = Bundle.main.path(forResource:file , ofType:fileExtension , inDirectory: inDirectory) else {
            print("File does not exists \(fileName) in \(inDirectory)")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
            player!.play()
            isPlayingSound = true
            on()
        } catch {
            print("Failed to play \(fileName) - \(error.localizedDescription)")
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
        isPlaying = false
        isSpeaking = false
        isPlayingSound = false
        
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
