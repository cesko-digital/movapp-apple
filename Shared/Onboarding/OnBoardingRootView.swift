//
//  OnBoardingRootView.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 04.05.2022.
//

import SwiftUI



struct OnBoardingRootView: View {
    
    @EnvironmentObject var languageService: LanguageService
    @State var setLanguage: SetLanguage?
    @State var languageSet: Bool = false
    
    @Binding var isBoardingCompleted: Bool
    
    let userDefaultsStore: UserDefaultsStore
    
    var body: some View {
        
        
        if let setLanguage = self.setLanguage {
            OnBoardingTutorialsPagerView  {
                withAnimation {
                    self.setLanguage = nil
                }
            } onStart: {
                withAnimation {
                    languageService.currentLanguage = setLanguage
                    
                    userDefaultsStore.storeOnBoardingComplete()
                    
                    isBoardingCompleted.toggle()
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
    static let languageService = LanguageService(userDefaultsStore: userDefaultsStore, dictionaryDataStore: DictionaryDataStore())
    
    static var previews: some View {
        OnBoardingRootView(isBoardingCompleted: .constant(false), userDefaultsStore: userDefaultsStore)
            .environmentObject(languageService)
        
    }
}
