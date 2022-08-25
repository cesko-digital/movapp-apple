//
//  OnboardingWelcomeView.swift
//  Movapp (iOS)
//
//  Created by Filip Novák on 03.05.2022.
//

import SwiftUI



struct OnBoardingWelcomeView: View {
    let onLanguageSelected: (_ language: Languages) -> Void

    private let gridLayout: [GridItem] = [GridItem(.adaptive(minimum: 113.42)), GridItem(.adaptive(minimum: 113.42))]

    var body: some View {
        VStack {
            VStack {
                Text("on_boarding_welcome")
                    .foregroundColor(Color("colors/primary"))
                    .font(.system(size: 32))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("on_boarding_choice_native")
                    .foregroundColor(Color("colors/text"))
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
            }
            .padding(.bottom, 72)

            LazyVGrid(columns: gridLayout, alignment: .center, spacing: 48) {
                ForEach(Languages.allCases, id: \.title) { item in
                    OnBoardingWelcomeButton(language: item) {
                        onLanguageSelected(item)
                    }
                    .accessibilityIdentifier("welcome-\(item.translationKey)")
                }
            }
        }
        .padding()
    }
}

struct OnBoardingWelcomeView_Previews: PreviewProvider {   
    static var previews: some View {
        
        OnBoardingWelcomeView { language in
            print(language)
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))

        OnBoardingWelcomeView { language in
            print(language)
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone SE 3rd generation)"))
    }
}
