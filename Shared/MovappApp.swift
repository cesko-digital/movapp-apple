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
    
    let langaugeService: LanguageService
    let soundService = SoundService()
    let favoritesProvider: TranslationFavoritesProvider
    let favoritesService: TranslationFavoritesService
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear // gets also rid of the bottom border of the navigation bar
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Color("colors/primary"))
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().tintColor = UIColor.white;
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        self.langaugeService = LanguageService(userDefaultsStore: userDefaultsStore, dictionaryDataStore: dictionaryDataStore)
        self.favoritesService = TranslationFavoritesService(userDefaultsStore: userDefaultsStore)
        self.favoritesProvider = TranslationFavoritesProvider(favoritesService: favoritesService)
    }
    
    var body: some Scene {
        WindowGroup {
            RootContentView()
                .environmentObject(langaugeService)
                .environmentObject(soundService)
                .environmentObject(favoritesService)
                .environmentObject(favoritesProvider)
                .environmentObject(dictionaryDataStore)
                .environmentObject(alphabetDataStore)
                .environmentObject(forKidsDataStore)
        }
    }
}
