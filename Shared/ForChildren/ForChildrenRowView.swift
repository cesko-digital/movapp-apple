//
//  ForChildrenRowView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 12.04.2022.
//

import SwiftUI


private extension Image {
    func flagStyle () -> some View {
        self.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.8), radius: 38, x: 0, y: 19)
    }
}


private extension Text {
    func languageStyle () -> some View {
        self.font(.system(size: 20))
            .fontWeight(.bold)
    }
}

struct ForChildrenRowView: View {
    let translation: String
    let transcription: String
    let language: Languages
    
    var body: some View {
        HStack {
            Image("icons/flags/\(language.flag.rawValue)")
                .flagStyle()
            
            Text(language.title)
                .languageStyle()
            
            Spacer()
        }
        HStack {
            VStack(alignment: .leading) {
                Text(translation)
                    .foregroundColor(Color("colors/text"))
                Text("[\(transcription)]")
                    .foregroundColor(Color("colors/secondary"))
            }
            Spacer()
            SpeakButtonView(language: language, text: translation)
        }
    }
}

struct ForChildrenRowView_Previews: PreviewProvider {
    static let soundService = SoundService()
    
    static var previews: some View {
        ForChildrenRowView(
            translation: ForChildrenItem.example.translationFrom,
            transcription: ForChildrenItem.example.transcriptionFrom,
            language: Languages.cs
        ).environmentObject(soundService)
    }
}
