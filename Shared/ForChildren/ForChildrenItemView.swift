//
//  ForChildrenItem.swift
//  Movapp (iOS)
//
//  Created by Daryna Polevyk on 11.04.2022.

import SwiftUI



struct ForChildrenItemView: View {
    let item: ForChildrenItem
    let selectedLanguage: SetLanguage
    
    @EnvironmentObject var soundService: SoundService
    
    var body: some View {
        
        CardView({
            Content {
                // Ensure that the image is not stretched to wide and to big
                Image("for-children/\(item.imageName)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 300)
                    .padding(20)
                    .onTapGesture {
                        // I want to learn czech language
                        if selectedLanguage.flipFromWithTo == true {
                            soundService.speach(language: Languages.cs, text: item.translationFrom)
                        }
                    }
            }
            
            Footer {
                ForChildrenRowView(translation: item.translationFrom, transcription: item.transcriptionFrom, language: Languages.cs)
                
                ForChildrenRowView(translation: item.translationTo, transcription: item.transcriptionTo, language: Languages.uk)
            }
            
        }, spacing: 0)
    }
}

struct ForChildrenItem_Previews: PreviewProvider {
    static let soundService = SoundService()
    
    static var previews: some View {
        ForChildrenItemView(item: ForChildrenItem.example, selectedLanguage: .csUk)
            .environmentObject(soundService)
    }
}

