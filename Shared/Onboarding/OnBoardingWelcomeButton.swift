//
//  OnBoardingWelcomeButton.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.05.2022.
//

import SwiftUI

struct OnBoardingWelcomeButton: View {
    let language: Languages

    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Image("icons/flags/\(language.flag.rawValue)")
                    .resizable()
                    .frame(width: 113.42, height: 74.31)
                    .shadow(color: .black.opacity(0.4), radius: 6, x: 0, y: 4)

                Text(LocalizedStringKey(language.title))
                    .foregroundColor(Color("colors/primary"))
                    .font(.system(size: 25))
            }
        }
    }
}



struct OnBoardingWelcomeButton_Previews: PreviewProvider {
    
    static var previews: some View {
        OnBoardingWelcomeButton(language: .cs) {
            
        }
        .previewLayout(.sizeThatFits)
        
        OnBoardingWelcomeButton(language: .uk) {

        }
        .previewLayout(.sizeThatFits)
        
    }
}
