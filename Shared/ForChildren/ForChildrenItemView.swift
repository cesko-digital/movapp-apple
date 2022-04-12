//
//  ForChildrenItem.swift
//  Movapp (iOS)
//
//  Created by Daryna Polevyk on 11.04.2022.

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


struct ForChildrenItemView: View {
    let item: ForKidsItem
    
    var body: some View {
        
        VStack {
            // Ensure that the image is not stretched to wide and to big
            Image("for-children/\(item.imageName)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 300)
                .padding(20)
            
            VStack {
                HStack {
                    Image("icons/flags/czech")
                        .flagStyle()
                    
                    Text("česky")
                        .languageStyle()
                    
                    Spacer()
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.translationFrom)
                            .foregroundColor(Color("colors/text"))
                        Text("[\(item.transcriptionFrom)]")
                            .foregroundColor(Color("colors/secondary"))
                    }
                    Spacer()
                    Image(systemName: "play.circle") //(systemName: soundService.isPlaying ? "stop.circle" : "play.circle")
                        .resizable()
                        .foregroundColor(Color("colors/action"))
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            // soundService.speach(language: language, text: example.example)
                        }
                }
                HStack {
                    Image("icons/flags/ukraine")
                        .flagStyle()
                    
                    Text("ukrajinsky")
                        .languageStyle()
                    Spacer()
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.translationTo)
                            .foregroundColor(Color("colors/text"))
                        Text("[\(item.transcriptionTo)]")
                            .foregroundColor(Color("colors/secondary"))
                    }
                    Spacer()
                    Image(systemName: "play.circle") //(systemName: soundService.isPlaying ? "stop.circle" : "play.circle")
                        .resizable()
                        .foregroundColor(Color("colors/action"))
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            // soundService.speach(language: language, text: example.example)
                        }
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
}

struct ForChildrenItem_Previews: PreviewProvider {
    static var previews: some View {
        ForChildrenItemView(item: ForKidsItem.example)
    }
}

