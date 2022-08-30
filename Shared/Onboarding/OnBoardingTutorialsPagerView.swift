//
//  OnBoardingTutorialsPagerView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.05.2022.
//

import Foundation
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
             
            ZStack(alignment: .bottom) {
                TabView(selection: $selected) {
                    OnBoardingTutorialView(title: "on_boarding_info_0_title",
                                           subTitle: String(format: NSLocalizedString("on_boarding_info_0_description", comment: ""),
                                                            NSLocalizedString(selectedToLearnLanguage.titleAccusative, comment: "")))
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
                    withAnimation {
                        isLastIndexSelected = newValue == tabLastElementIndex
                    }
                })
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .accessibilityIdentifier("tutorial-tab-view")

                if isLastIndexSelected {
                    Button("on_boarding_exit", action: start)
                        .buttonStyle(PrimaryButtonStyle())
                        .frame(maxWidth: .infinity, alignment: .bottom)
                        .padding()
                        .accessibilityIdentifier("start-learning-button")
                }
            }

            HStack {
                Button("on_boarding_back", action: onBack)
                    .frame(height: 44)
                    .accessibilityIdentifier("welcome-go-start")
                    .padding()

                Spacer()

                if !isLastIndexSelected {
                    Button("on_boarding_skip", action: start)
                        .frame(height: 44)
                        .accessibilityIdentifier("start-learning-button")
                        .padding()
                }
            }
        }
    }

    private func start() {
        onStart()
        selected = 0
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
