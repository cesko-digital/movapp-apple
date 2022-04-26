//
//  MovappApp.swift
//  Shared
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

@main
struct MovappApp: App {
    
    let langaugeService: LanguageService
    let soundService = SoundService()
    let favoritesService = TranslationFavoritesService()
    let favoritesProvider: TranslationFavoritesProvider
    let dictionaryDataStore = DictionaryDataStore()
    let alphabetDataStore = AlphabetDataStore()
    let forKidsDataStore = ForChildrenDataStore()
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear // gets also rid of the bottom border of the navigation bar
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Color("colors/primary"))
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().tintColor = UIColor.white;
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        self.langaugeService = LanguageService(dictionaryDataStore: dictionaryDataStore)
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
