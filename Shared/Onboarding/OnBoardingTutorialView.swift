//
//  OnBoardingTutorialView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.05.2022.
//

import SwiftUI

struct OnBoardingTutorialView: View {
    let title: LocalizedStringKey
    let subTitle: String

    @State var isVisible: Bool = false

    var body: some View {
        VStack(spacing: 30) {
            Text(title)
                .font(.system(.title))
                .foregroundColor(Color("colors/primary"))

            Text(subTitle)
                .foregroundColor(Color("colors/text"))
                .multilineTextAlignment(.center)
        }
        .scaleEffect(isVisible ? 1.0 : 0.8)
        .animation(.spring(), value: isVisible)
        .padding()
        .onAppear {
            isVisible = true
        }
    }

}

struct OnBoardingTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        // swiftlint:disable:next line_length
        OnBoardingTutorialView(title: "Slovníček", subTitle: "Naučte se stovky základních slovíček a frází čtením i poslechem. Slovíčka třídíme dle životních situací.")
            .previewLayout(.sizeThatFits)
    }
}
