//
//  OnBoardingWelcomeButton.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.05.2022.
//

import SwiftUI

struct OnBoardingWelcomeButton: View {
    let text: String
    let backgroundColor: Color
    let textColor: Color
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(text)
                    .foregroundColor(textColor)
                    .font(.system(size: 25))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .foregroundColor(textColor)
            }
            .foregroundColor(textColor)
            .padding(.horizontal)
            .padding(.vertical, 50)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
        }
        .buttonStyle(ScaleButtonStyle())
        
    }
}



struct OnBoardingWelcomeButton_Previews: PreviewProvider {
    
    static var previews: some View {
        OnBoardingWelcomeButton(text: "Я хочу вивчити Чеський", backgroundColor: Color("colors/primary"), textColor: .white) {
            
        }
        .previewLayout(.sizeThatFits)
        
        OnBoardingWelcomeButton(text: "Chci se naučit ukrajinsky", backgroundColor: Color("colors/yellow"), textColor: Color("colors/primary")) {
            
        }
        .previewLayout(.sizeThatFits)
        
    }
}
