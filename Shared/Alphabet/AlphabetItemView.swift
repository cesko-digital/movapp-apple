//
//  AlphabetItemView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 10.04.2022.
//

import SwiftUI

struct AlphabetItemView: View {
    @EnvironmentObject var soundService: SoundService
    
    let item: AlphabetItem
    let language: Languages
    
    private let soundsDirectory : String
    
    init (item: AlphabetItem, language: Languages) {
        self.item = item
        self.language = language
        soundsDirectory = "data/\(language.rawValue)-alphabet"
    }
    
    var body: some View {
        CardView {
            Content {
                Text(item.letter)
                    .font(.system(size: 100))
                    .foregroundColor(Color("colors/text"))
                
                if item.fileName != nil {
                    Image(systemName: soundService.isPlaying ? "stop.circle" : "play.circle")
                        .resizable()
                        .foregroundColor(Color("colors/action"))
                        .frame(width: 52, height: 52)
                        .onTapGesture {
                            soundService.play(item.id, inDirectory: soundsDirectory)
                        }
                }
                
                Text(item.transcription)
                    .font(.system(size: 25))
                    .foregroundColor(Color("colors/text"))
            }
            Footer {
                ForEach(item.examples, id: \.example) { example in
                    HStack {
                        Text(example.example)
                            .foregroundColor(Color("colors/text"))
                        
                        Spacer()
                        
                        Text("[\(example.transcription)]")
                            .foregroundColor(Color("colors/secondary"))
                        
                        Spacer()
                        
                        Image(systemName: soundService.isPlaying ? "stop.circle" : "play.circle")
                            .resizable()
                            .foregroundColor(Color("colors/action"))
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                soundService.speach(language: language, text: example.example)
                            }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
    
    
}

struct AlphabetItemView_Previews: PreviewProvider {
    static let soundService = SoundService()
    
    static var previews: some View {
        AlphabetItemView(item: AlphabetItem.example, language: SetLanguage.ukCs.language.from)
            .environmentObject(soundService)
    }
}
