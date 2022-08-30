//
//  OnBoardingRootView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.05.2022.
//

import SwiftUI

enum OnboardingState {
    case nativeLanguage
    case toLearnLanguage
    case onboarding
}

struct OnBoardingRootView: View {
    
    @EnvironmentObject var languageStore: LanguageStore
    @EnvironmentObject var onBoardingStore: OnBoardingStore
    
    @State private var selectedToLearnLanguage: Languages?
    @State private var selectedNativeLanguage: Languages?
    @State var state: OnboardingState = .nativeLanguage

    var body: some View {
        Group {
            switch state {
            case .nativeLanguage:
                initialOnboardingState()
            case .toLearnLanguage:
                toLearLanguageView()
            case .onboarding:
                onboardingView()
            }
        }
    }

    private func initialOnboardingState() -> some View {
        OnBoardingWelcomeView { language in
            withAnimation {
                self.selectedNativeLanguage = language
                self.state = language == .uk ? .toLearnLanguage : .onboarding
            }
        }
    }

    private func toLearLanguageView() -> some View {
        OnBoardingToLearnView(
            onLanguageSelected: { language in
                withAnimation {
                    self.selectedToLearnLanguage = language
                    self.state = .onboarding
                }
            },
            onBack: {
                withAnimation {
                    self.selectedToLearnLanguage = nil
                    self.state = .nativeLanguage
                }
            }
        )
    }

    private func onboardingView() -> some View {
        guard let selectedNativeLanguage = selectedNativeLanguage else {
            fatalError("You must select your native language first.")
        }

        return OnBoardingTutorialsPagerView(
            selectedToLearnLanguage: selectedToLearnLanguage ?? .uk,
            onBack: {
                withAnimation {
                    let nextState: OnboardingState = selectedToLearnLanguage == nil ? .nativeLanguage : .toLearnLanguage
                    self.selectedToLearnLanguage = nil
                    self.state = nextState
                }
            },
            onStart: {
                languageStore.currentLanguage = getSetLanguage(nativeLanguage: selectedNativeLanguage, toLearnLanguage: selectedToLearnLanguage)
                onBoardingStore.isBoardingCompleted.toggle()
            }
        )
    }

    private func getSetLanguage(nativeLanguage: Languages, toLearnLanguage: Languages?) -> SetLanguage {
        guard let toLearnLanguage = toLearnLanguage else {
            return SetLanguage(language: Language(main: nativeLanguage, source: .uk), flipFromWithTo: false)
        }

        return SetLanguage(language: Language(main: toLearnLanguage, source: nativeLanguage), flipFromWithTo: true)
    }
}

struct OnBoardingRootView_Previews: PreviewProvider {
    static let userDefaultsStore = UserDefaultsStore()
    static let dictionaryDataStore = DictionaryDataStore()
    static let languageStore = LanguageStore(userDefaultsStore: userDefaultsStore, dictionaryDataStore: dictionaryDataStore, forChildrenDataStore: ForChildrenDataStore(dictionaryDataStore: dictionaryDataStore))
    static let onBoardingStore = OnBoardingStore(userDefaultsStore: userDefaultsStore)
    
    static var previews: some View {
        OnBoardingRootView()
            .environmentObject(languageStore)
            .environmentObject(onBoardingStore)

        OnBoardingRootView(state: .toLearnLanguage)
            .environmentObject(languageStore)
            .environmentObject(onBoardingStore)

        OnBoardingRootView(state: .onboarding)
            .environmentObject(languageStore)
            .environmentObject(onBoardingStore)
        
    }
}
