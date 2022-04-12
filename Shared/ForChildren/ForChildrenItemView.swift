//
//  ForChildrenItem.swift
//  Movapp (iOS)
//
//  Created by Daryna Polevyk on 11.04.2022.

import SwiftUI



struct ForChildrenItemView: View {
    let item: ForChildrenItem
    
    var body: some View {
        
        CardView({
            Content {
                // Ensure that the image is not stretched to wide and to big
                Image("for-children/\(item.imageName)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 300)
                    .padding(20)
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
        ForChildrenItemView(item: ForChildrenItem.example)
            .environmentObject(soundService)
    }
}

