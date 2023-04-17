//
//  ForChildrenItem.swift
//  Movapp (iOS)
//
//  Created by Daryna Polevyk on 11.04.2022.

import SwiftUI

struct ForChildrenItemView: View {
    let item: Dictionary.Phrase
    let selectedLanguage: SetLanguage

    @EnvironmentObject var soundService: SoundService

    var body: some View {

        CardView({
            Content {
                if let imageName = item.imageName {
                    // Ensure that the image is not stretched to wide and to big
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 300)
                        .padding(20)
                        .onTapGesture {

                            // I want to learn czech language
                            if selectedLanguage.flipFromWithTo == true {
                                soundService.play(path: item.main.soundFileName)
                            } else {
                                soundService.play(path: item.source.soundFileName)
                            }
                        }
                }

            }

            Footer {
                ForChildrenRowView(translation: item.main, language: selectedLanguage.language.main)
                ForChildrenRowView(translation: item.source, language: selectedLanguage.language.source)
            }

        }, spacing: 0)
    }
}

struct ForChildrenItem_Previews: PreviewProvider {
    static let soundService = SoundService()

    static var previews: some View {
        ForChildrenItemView(item: examplePhrase, selectedLanguage: .csUk)
            .environmentObject(soundService)
    }
}
