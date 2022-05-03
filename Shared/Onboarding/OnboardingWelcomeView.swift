//
//  OnboardingWelcomeView.swift
//  Movapp (iOS)
//
//  Created by Filip Novák on 03.05.2022.
//

import SwiftUI



struct OnBoardingWelcomeView: View {
    let onLanguageSelected: (_ language: SetLanguage) -> Void
    
    var body: some View {
        VStack {
            VStack {
                
                Text("Vítejte v MOVAPP!")
                    .foregroundColor(Color("colors/primary"))
                    .font(.system(size: 25))
                    .padding()
                
                Text("Vyberte jazyk, který se chcete naučit")
                    .foregroundColor(Color("colors/primary"))
                    .padding(.horizontal, 16)
            }
            .padding(.bottom, 40)
            
            VStack() {
                // These buttons should not be translated - sets the correct language
                // At this moment, later it will be changed when we have more languages
                OnBoardingWelcomeButton(text: "Я хочу вивчити Чеський", backgroundColor: Color("colors/primary"), textColor: .white) {
                    onLanguageSelected(.ukCs)
                }
                .accessibilityIdentifier("welcome-ukraine")
                
                OnBoardingWelcomeButton(text: "Chci se naučit ukrajinsky", backgroundColor: Color("colors/yellow"), textColor: Color("colors/primary"))  {
                    onLanguageSelected(.csUk)
                }
                .accessibilityIdentifier("welcome-czech")
            }
        }
        .padding()
    }
}

struct OnBoardingWelcomeView_Previews: PreviewProvider {
    @State static var language: SetLanguage?
    
    static var previews: some View {
        
        OnBoardingWelcomeView { language in
            print(language)
        }
    }
}
