//
//  OnboardingView.swift
//  MovappWatch Watch App
//
//  Created by Jakub Ruzicka on 16.04.2023.
//

import SwiftUI

struct OnboardingView: View {

    @State private var selectedFirstLanguage: Languages = .cs
    @State private var selectedSecondLanguage: Languages = .uk

    var filteredSecondLanguage: [Languages] {
        if selectedFirstLanguage != .uk {
            return [.uk]
        }

        return Languages.allCases.filter { $0 != .uk }
    }

    var body: some View {
        VStack {
            Picker("i_know", selection: $selectedFirstLanguage) {
                ForEach(Languages.allCases, id: \.rawValue) {
                    Text(LocalizedStringKey($0.translationKey))
                        .tag($0)
                }
            }
            .pickerStyle(.navigationLink)

            Picker("i_want_learn", selection: $selectedSecondLanguage) {
                ForEach(filteredSecondLanguage, id: \.rawValue) {
                    Text(LocalizedStringKey($0.translationKey))
                        .tag($0)
                }
            }
            .pickerStyle(.navigationLink)

            Button("on_boarding_exit") {
                let flip = selectedFirstLanguage == .uk
                let main = flip ? selectedSecondLanguage : selectedFirstLanguage
                let source = flip ? selectedFirstLanguage : selectedSecondLanguage

                LanguageProvider.shared.language = SetLanguage(language: Language(main: main, source: source),
                                                               flipFromWithTo: flip)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
