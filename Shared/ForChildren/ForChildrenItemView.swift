//
//  ForChildrenItem.swift
//  Movapp (iOS)
//
//  Created by Daryna Polevyk on 11.04.2022.

import SwiftUI

struct ForChildrenItemView: View {
    let item: ForKidsItem
    
    var body: some View {
        
            VStack (spacing: 20) {
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
                VStack {
                    HStack {
                        Image("flagCzech")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.8), radius: 38, x: 0, y: 19)
                        Text("česky")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.czTranslation)
                                .foregroundColor(Color("colors/text"))
                            Text("[\(item.czTranscription)]")
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
                        Image("flagUkraine")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.8), radius: 38, x: 0, y: 19)
                        Text("ukrajinsky")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.uaTranslation)
                                .foregroundColor(Color("colors/text"))
                            Text("[\(item.uaTranscription)]")
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

