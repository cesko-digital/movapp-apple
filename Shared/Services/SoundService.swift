//
//  SoundService.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import Foundation
import AVFoundation

class SoundService: NSObject, ObservableObject {
    
    // Create a speech synthesizer.
    let synthesizer = AVSpeechSynthesizer()
    
    @Published var isSpeaking: Bool = false
    @Published var isShowingSpeakingErrorAlert: Bool = false
    
    
    override init () {
        super.init()
        synthesizer.delegate = self
    }
    
    
    // https://developer.apple.com/documentation/avfoundation/speech_synthesis#overview
    func speach(language: String, text: String) {
        // Create an utterance.
        let utterance = AVSpeechUtterance(string: text)
        
        // Configure the utterance.
        //utterance.rate = 0.57
        //utterance.pitchMultiplier = 0.8
        //utterance.postUtteranceDelay = 0.2
        //utterance.volume = 0.8
        
        // Retrieve the British English voice.
        let voice = AVSpeechSynthesisVoice(language: language)
        
        // Assign the voice to the utterance.
        utterance.voice = voice
        
        
        // Tell the synthesizer to speak the utterance.
        synthesizer.speak(utterance)
    }
    
    func stop () {
        if isSpeaking == true {
            self.synthesizer.stopSpeaking(at: .immediate)
        }
    }
}

extension SoundService: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        self.isSpeaking = true
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        self.isSpeaking = false
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.isSpeaking = false
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
}
