//
//  MovappApp.swift
//  Shared
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

@main
struct MovappApp: App {
    
    let dictionaryDataStore = DictionaryDataStore()
    let alphabetDataStore = AlphabetDataStore()
    let forKidsDataStore = ForChildrenDataStore()
    let userDefaultsStore = UserDefaultsStore()
    let teamDataStore = TeamDataStore()
    
    let languageService: LanguageService
    let soundService = SoundService()
    let favoritesProvider: TranslationFavoritesProvider
    let favoritesService: TranslationFavoritesService
    
    @State var isBoardingCompleted: Bool
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear // gets also rid of the bottom border of the navigation bar
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Color("colors/primary"))
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().tintColor = UIColor.white;
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        self.languageService = LanguageService(userDefaultsStore: userDefaultsStore, dictionaryDataStore: dictionaryDataStore)
        self.favoritesService = TranslationFavoritesService(userDefaultsStore: userDefaultsStore)
        self.favoritesProvider = TranslationFavoritesProvider(favoritesService: favoritesService)
        
        isBoardingCompleted = userDefaultsStore.getOnBoardingComplete()
    }
    
    var body: some Scene {
        WindowGroup {
            if isBoardingCompleted {
                RootContentView()
                    .environmentObject(languageService)
                    .environmentObject(soundService)
                    .environmentObject(favoritesService)
                    .environmentObject(favoritesProvider)
                    .environmentObject(dictionaryDataStore)
                    .environmentObject(alphabetDataStore)
                    .environmentObject(forKidsDataStore)
                    .environmentObject(teamDataStore)
            } else {
                OnBoardingRootView(isBoardingCompleted: $isBoardingCompleted, userDefaultsStore: userDefaultsStore)
                    .environmentObject(languageService)
            }
            
        }
    }
}
