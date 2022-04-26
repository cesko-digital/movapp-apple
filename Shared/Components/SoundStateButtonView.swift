//
//  SoundStateButtonView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 26.04.2022.
//

import SwiftUI

struct SoundStateButtonView: View {
    let isPlaying: Bool
    let onTap: () -> Void
    
    var body: some View {
        Image(systemName: isPlaying ? "stop.circle" : "play.circle")
            .resizable()
            .foregroundColor(Color("colors/action"))
            .frame(width: 30, height: 30)
            .onTapGesture {
                onTap()
            }
    }
}

struct SoundStateButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        SoundStateButtonView(isPlaying: false) {
            print("Hello")
        }
        .padding()
        .previewLayout(.sizeThatFits)
        
        
        SoundStateButtonView(isPlaying: true) {
            print("Hello")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
