//
//  OnBoardingRootView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.05.2022.
//

import SwiftUI



struct OnBoardingRootView: View {
    
    @EnvironmentObject var languageStore: LanguageStore
    @EnvironmentObject var onBoardingStore: OnBoardingStore
    
    @State var setLanguage: SetLanguage?
    
    var body: some View {
        
        if let setLanguage = self.setLanguage {
            OnBoardingTutorialsPagerView  {
                withAnimation {
                    self.setLanguage = nil
                }
            } onStart: {
                withAnimation {
                    
                    languageStore.currentLanguage = setLanguage
                    onBoardingStore.isBoardingCompleted.toggle()
                    
                    self.setLanguage = nil
                }
            }
        } else {
            OnBoardingWelcomeView { language in
                withAnimation {
                    self.setLanguage = language
                }
            }
        }
    }
}

struct OnBoardingRootView_Previews: PreviewProvider {
    static let userDefaultsStore = UserDefaultsStore()
    static let languageStore = LanguageStore(userDefaultsStore: userDefaultsStore, dictionaryDataStore: DictionaryDataStore())
    static let onBoardingStore = OnBoardingStore(userDefaultsStore: userDefaultsStore)
    
    static var previews: some View {
        OnBoardingRootView()
            .environmentObject(languageStore)
            .environmentObject(onBoardingStore)
        
    }
}
