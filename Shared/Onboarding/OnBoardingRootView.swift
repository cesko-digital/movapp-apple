//
//  OnBoardingRootView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.05.2022.
//

import SwiftUI

enum OnboardingState {
    case nativeLanguage
    case toLearnLanguage(native: Languages)
    case onboarding(native: Languages, toLearn: Languages)
}

struct OnBoardingRootView: View {

    @EnvironmentObject var languageStore: LanguageStore
    @EnvironmentObject var onBoardingStore: OnBoardingStore

    @State var state: OnboardingState = .nativeLanguage

    var body: some View {
        ZStack(alignment: .topLeading) {
            Group {
                switch state {
                case .nativeLanguage:
                    initialOnboardingState()
                case let .toLearnLanguage(native):
                    toLearLanguageView(native: native)
                case let .onboarding(native, toLearn):
                    onboardingView(native: native, toLearn: toLearn)
                }
            }

            // Add background under the status bar to ensure that status bar can be .lightContent
            // https://designcode.io/swiftui-handbook-status-bar-background-on-scroll
            Rectangle()
                .foregroundColor(Color("colors/primary"))
                .ignoresSafeArea()
                .frame(height: 0)
        }
    }

    private func initialOnboardingState() -> some View {
        OnBoardingWelcomeView { language in
            withAnimation {
                self.state = language == .uk
                ? .toLearnLanguage(native: language)
                : .onboarding(native: language, toLearn: .uk)
            }
        }
    }

    private func toLearLanguageView(native: Languages) -> some View {
        OnBoardingToLearnView(
            onLanguageSelected: { language in
                withAnimation {
                    self.state = .onboarding(native: native, toLearn: language)
                }
            },
            onBack: {
                withAnimation {
                    self.state = .nativeLanguage
                }
            }
        )
    }

    private func onboardingView(native: Languages, toLearn: Languages) -> some View {
        return OnBoardingTutorialsPagerView(
            selectedToLearnLanguage: toLearn,
            onBack: {
                withAnimation {
                    let nextState: OnboardingState = native == .uk ? .toLearnLanguage(native: native) : .nativeLanguage
                    self.state = nextState
                }
            },
            onStart: {
                languageStore.currentLanguage = getSetLanguage(nativeLanguage: native, toLearnLanguage: toLearn)
                onBoardingStore.isBoardingCompleted.toggle()
            }
        )
    }

    private func getSetLanguage(nativeLanguage: Languages, toLearnLanguage: Languages) -> SetLanguage {
        if toLearnLanguage == .uk {
            return SetLanguage(language: Language(main: nativeLanguage, source: .uk), flipFromWithTo: false)
        }

        return SetLanguage(language: Language(main: toLearnLanguage, source: nativeLanguage), flipFromWithTo: true)
    }
}

struct OnBoardingRootView_Previews: PreviewProvider {
    static let userDefaultsStore = UserDefaultsStore()
    static let dictionaryDataStore = DictionaryDataStore.shared
    static let languageStore = LanguageStore(
        userDefaultsStore: userDefaultsStore,
        dictionaryDataStore: dictionaryDataStore,
        forChildrenDataStore: ForChildrenDataStore(dictionaryDataStore: dictionaryDataStore))
    static let onBoardingStore = OnBoardingStore(userDefaultsStore: userDefaultsStore)

    static var previews: some View {
        OnBoardingRootView()
            .environmentObject(languageStore)
            .environmentObject(onBoardingStore)

        OnBoardingRootView(state: .toLearnLanguage(native: .cs))
            .environmentObject(languageStore)
            .environmentObject(onBoardingStore)

        OnBoardingRootView(state: .onboarding(native: .uk, toLearn: .cs))
            .environmentObject(languageStore)
            .environmentObject(onBoardingStore)

    }
}
