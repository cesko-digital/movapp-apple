//
//  OnBoardingTutorialsPagerView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.05.2022.
//

import SwiftUI

struct OnBoardingTutorialsPagerView: View {
    let selectedToLearnLanguage: Languages
    let onBack: () -> Void
    let onStart: () -> Void

    @State private var selected = 0
    private let tabLastElementIndex = 3
    @State private var isLastIndexSelected = false

    var body: some View {
        ZStack(alignment: .topLeading) {
             
            VStack {
                TabView(selection: $selected) {
                    OnBoardingTutorialView(title: "on_boarding_info_0_title",
                                           subTitle: String(format: String(localized: "on_boarding_info_0_description"), selectedToLearnLanguage.title))
                    .tag(0)
                    
                    OnBoardingTutorialView(title: "on_boarding_info_1_title",
                                           subTitle: String(localized: "on_boarding_info_1_description"))
                    .tag(1)
                    
                    OnBoardingTutorialView(title: "on_boarding_info_2_title",
                                           subTitle: String(localized: "on_boarding_info_2_description"))
                    .tag(2)

                    OnBoardingTutorialView(title: "on_boarding_info_3_title",
                                           subTitle: String(localized: "on_boarding_info_3_description"))
                    .tag(3)
                }
                .onChange(of: selected, perform: { newValue in
                    isLastIndexSelected = newValue == tabLastElementIndex
                })
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: isLastIndexSelected ? .never : .always))
                .accessibilityIdentifier("tutorial-tab-view")

                if isLastIndexSelected {
                    Button("Start learning", action: onStart)
                        .buttonStyle(PrimaryButtonStyle())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .accessibilityIdentifier("start-learning-button")
                }
            }
            HStack {
                Button("on_boarding_back", action: onBack)
                    .accessibilityIdentifier("welcome-go-start")
                    .padding()

                Spacer()

                if !isLastIndexSelected {
                    Button("on_boarding_skip", action: onStart)
                        .accessibilityIdentifier("start-learning-button")
                        .padding()
                }
            }
        }
    }
    
}

struct OnBoardingTutorialsPagerView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingTutorialsPagerView(selectedToLearnLanguage: .cs) {
            print("Back")
        } onStart: {
            print("Start")
        }
        
    }
}
