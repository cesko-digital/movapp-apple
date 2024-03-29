//
//  OnBoardingToLearnView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 24.08.2022.
//

import SwiftUI

struct OnBoardingToLearnView: View {
    let onLanguageSelected: (_ language: Languages) -> Void
    let onBack: () -> Void

    private let gridLayout: [GridItem] = [GridItem(.fixed(140)), GridItem(.fixed(140))]
    private let languagesToSelect = Languages.allCases.filter { $0 != .uk }

    var body: some View {
        ZStack(alignment: .topLeading) {
            Button("on_boarding_back", action: onBack)
                .frame(height: 44)
                .accessibilityIdentifier("on_boarding_back")
                .padding()

            VStack(alignment: .center) {
                Spacer()
                Text("on_boarding_choice")
                    .foregroundColor(Color("colors/primary"))
                    .font(.system(size: 32))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 72)

                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 48) {
                    ForEach(languagesToSelect, id: \.title) { item in
                        OnBoardingWelcomeButton(language: item) {
                            onLanguageSelected(item)
                        }
                        .accessibilityIdentifier("toLearn-\(item.translationKey)")
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct OnBoardingToLearnView_Previews: PreviewProvider {
    static var previews: some View {

        OnBoardingToLearnView(
            onLanguageSelected: { _ in },
            onBack: {}
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))

        OnBoardingToLearnView(
            onLanguageSelected: { _ in },
            onBack: {}
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))

        OnBoardingToLearnView(
            onLanguageSelected: { _ in },
            onBack: {}
        )
        .previewDevice("iPad Air (5th generation)")
        .previewDisplayName("iPad Air (5th generation)")
    }
}
