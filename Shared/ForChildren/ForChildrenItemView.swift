//
//  ForChildrenItem.swift
//  Movapp (iOS)
//
//  Created by Daryna Polevyk on 11.04.2022.

import SwiftUI

struct ForChildrenItemView: View {
    @EnvironmentObject var soundService: SoundService
    
    let item: ForKidsItem
    
    init (item: ForKidsItem) {
        self.item = item
    }
    
    var body: some View {
        
        VStack (spacing: 20) {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
            VStack {
                
                languageTitle(flag: "flagCzech", language: "česky")
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.translationFrom)
                            .foregroundColor(Color("colors/text"))
                        Text("[\(item.transcriptionFrom)]")
                            .foregroundColor(Color("colors/secondary"))
                    }
                    Spacer()
                    playButton(language: Language.cs, text: item.translationFrom)
                }
                
                languageTitle(flag: "flagUkraine", language: "ukrajinsky")
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.translationTo)
                            .foregroundColor(Color("colors/text"))
                        Text("[\(item.transcriptionTo)]")
                            .foregroundColor(Color("colors/secondary"))
                    }
                    
                    Spacer()
                    
                    playButton(language: Language.uk, text: item.translationTo)
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color("colors/yellow"))
            
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.04), radius: 38, x: 0, y: 19)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.04), radius: 12, x: 0, y: 15)
    }
    
    private func languageTitle(flag: String, language: String) -> some View {
        HStack {
            Image(flag)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.8), radius: 38, x: 0, y: 19)
            Text(language)
                .font(.system(size: 20))
                .fontWeight(.bold)
            Spacer()
        }
    }
    
    private func playButton(language: String, text: String) -> some View {
        Image (systemName: soundService.isPlaying ? "stop.circle" : "play.circle")
            .resizable()
            .foregroundColor(Color("colors/action"))
            .frame(width: 30, height: 30)
            .onTapGesture {
                soundService.speach(language: language, text: text)
            }
    }
}

struct ForChildrenItem_Previews: PreviewProvider {
    static var previews: some View {
        ForChildrenItemView(item: ForKidsItem.example)
    }
}

