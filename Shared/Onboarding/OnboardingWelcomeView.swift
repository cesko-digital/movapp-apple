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
                
                Text("Welcome")
                    .foregroundColor(Color("colors/primary"))
                    .font(.system(size: 25))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Choose language to learn")
                    .foregroundColor(Color("colors/primary"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
            }
            .padding(.bottom, 40)
            
            VStack() {
                // These buttons should not be translated - sets the correct language
                // At this moment, later it will be changed when we have more languages
                OnBoardingWelcomeButton(text: String(localized: "boarding_ukrainian_to_czech", comment: "Boarding button select ukraine to czech"), backgroundColor: Color("colors/primary"), textColor: .white) {
                    onLanguageSelected(.ukCs)
                }
                .accessibilityIdentifier("welcome-ukraine")
                
                OnBoardingWelcomeButton(text: String(localized: "boarding_czech_to_ukrainian", comment: "Boarding button select czech to ukrainian"), backgroundColor: Color("colors/yellow"), textColor: Color("colors/primary"))  {
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
