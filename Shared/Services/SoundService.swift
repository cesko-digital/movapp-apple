//
//  SoundService.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import Foundation
import AVFoundation

class SoundService {
    
    static var audioPlayer:AVAudioPlayer?
    
    // Create a speech synthesizer.
    static let synthesizer = AVSpeechSynthesizer()
    
 
    // https://developer.apple.com/documentation/avfoundation/speech_synthesis#overview
    static func speach(language: Language, text: String) {
        // Create an utterance.
        let utterance = AVSpeechUtterance(string: text)

        // Configure the utterance.
        //utterance.rate = 0.57
        //utterance.pitchMultiplier = 0.8
        //utterance.postUtteranceDelay = 0.2
        //utterance.volume = 0.8

        // Retrieve the British English voice.
        let voice = AVSpeechSynthesisVoice(language: language.speachLanguage)

        // Assign the voice to the utterance.
        utterance.voice = voice
        
        
        // Tell the synthesizer to speak the utterance.
        synthesizer.speak(utterance)
    }
}
