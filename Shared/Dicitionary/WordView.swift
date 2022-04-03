//
//  WordView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 03.04.2022.
//

import SwiftUI

struct WordView: View {
    
    let language: Language
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
            
            Image("icons/play")
                .foregroundColor(Color("colors/accent"))
                .padding(.vertical, 20)
                .padding(.leading, 10)
                .onTapGesture {
                    SoundService.speach(language: language, text: text)
                }
            
        }.frame(maxWidth: .infinity)
    }
}

struct WordView_Previews: PreviewProvider {
    
    static var previews: some View {
        WordView(
            language: .csUk,
            text: exampleTranslation.translation_from,
            transcription: exampleTranslation.transcription_from
        )
        
        WordView(
            language: .csUk,
            text: "asdsajdkljaksjdk ",
            transcription: "asodlsajdklj asd jksjadl jaklsjd kljsalkd jlksajd kljaskld jaljkl j"
        )
    }
}
