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
    let forChildrenDataStore: ForChildrenDataStore
    let userDefaultsStore = UserDefaultsStore()
    let teamDataStore = TeamDataStore()
    
    let languageStore: LanguageStore
    let soundService = SoundService()
    let favoritesProvider: PhrasesFavoritesProvider
    let favoritesService: PhraseFavoritesService
    
    @ObservedObject var onBoardingDataStore: OnBoardingStore
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear // gets also rid of the bottom border of the navigation bar
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Color("colors/primary"))
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().tintColor = UIColor.white;
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        self.forChildrenDataStore = ForChildrenDataStore(dictionaryDataStore: dictionaryDataStore)
        self.languageStore = LanguageStore(userDefaultsStore: userDefaultsStore, dictionaryDataStore: dictionaryDataStore, forChildrenDataStore: forChildrenDataStore)
        self.onBoardingDataStore = OnBoardingStore(userDefaultsStore: userDefaultsStore)
        self.favoritesService = PhraseFavoritesService(userDefaultsStore: userDefaultsStore, dictionaryDataStore: dictionaryDataStore)
        self.favoritesProvider = PhrasesFavoritesProvider(favoritesService: favoritesService)
    }
    
    var body: some Scene {
        WindowGroup {
            if onBoardingDataStore.isBoardingCompleted {
                RootContentView()
                    .environmentObject(languageStore)
                    .environmentObject(soundService)
                    .environmentObject(favoritesService)
                    .environmentObject(favoritesProvider)
                    .environmentObject(dictionaryDataStore)
                    .environmentObject(alphabetDataStore)
                    .environmentObject(forChildrenDataStore)
                    .environmentObject(teamDataStore)
                    .environmentObject(onBoardingDataStore)
            } else {
                OnBoardingRootView()
                    .environmentObject(languageStore)
                    .environmentObject(onBoardingDataStore)
            }
            
        }
    }
}
