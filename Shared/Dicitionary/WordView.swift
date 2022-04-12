//
//  WordView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import SwiftUI

struct WordView: View {
    
    @EnvironmentObject var soundService: SoundService
    
    let language: Languages
    let text: String
    let transcription: String
    
    func formatTranscription (_ string: String) -> String {
        return String(format: "[ %@ ]", string)
    }
    
    var body: some View {
        HStack () {
            VStack (alignment: .leading, spacing: 10) {
                Text(text)
                    .foregroundColor(Color("colors/text"))
                    .textSelection(.enabled)
                    .font(.system(size: 20))
                
                Text(formatTranscription(transcription))
                    .foregroundColor(Color("colors/secondary"))
                    .textSelection(.enabled)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Image(systemName: soundService.isPlaying ? "stop.circle" : "play.circle")
                .resizable()
                .foregroundColor(Color("colors/action"))
                .frame(width: 30, height: 30)
                .onTapGesture {
                    soundService.speach(language: language, text: text)
                    
                }
            
        }.frame(maxWidth: .infinity)
    }
}

struct WordView_Previews: PreviewProvider {
    
    static let soundService = SoundService()
    
    static var previews: some View {
        WordView(
            language: Languages.cs,
            text: exampleTranslation.translationFrom,
            transcription: exampleTranslation.transcriptionFrom
        ).environmentObject(soundService)
        
        WordView(
            language: Languages.uk,
            text: "asdsajdkljaksjdk ",
            transcription: "asodlsajdklj asd jksjadl jaklsjd kljsalkd jlksajd kljaskld jaljkl j"
        ).environmentObject(soundService)
    }
}
