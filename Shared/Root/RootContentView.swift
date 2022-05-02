//
//  ContentView.swift
//  Shared
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI


extension View {
    func setTabItem (_ item: RootItems) -> some View {
        self.tabItem {
            Label(item.title, image: item.icon)
        }.tag(item)
    }
}

struct RootContentView: View {
    @EnvironmentObject var languageService: LanguageService
    
    var body: some View {
        ZStack(alignment: .top) {
            
            TabView {
                DicitionaryView(selectedLanguage: languageService.currentLanguage)
                    .setTabItem(RootItems.dictionary)
                
                AlphabetView()
                    .setTabItem(RootItems.alphabet)
                
                ForChildrenView(selectedLanguage: languageService.currentLanguage)
                    .setTabItem(RootItems.for_children)
                
                MenuView(selectedLanguage: languageService.currentLanguage)
                    .setTabItem(RootItems.menu)
            }
            
            // Add background under the status bar to ensure that status bar can be .lightContent
            // https://designcode.io/swiftui-handbook-status-bar-background-on-scroll
            Rectangle()
                .foregroundColor(Color("colors/primary"))
                .ignoresSafeArea()
                .frame(height: 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let soundService = SoundService()
    static let userDefaultsStore = UserDefaultsStore()
    static let favoritesService = TranslationFavoritesService(userDefaultsStore: userDefaultsStore)
    static let favoritesProvider = TranslationFavoritesProvider(favoritesService: favoritesService)
    static let dictionaryDataStore = DictionaryDataStore()
    static let alphabetDataStore = AlphabetDataStore()
    static let forKidsDataStore = ForChildrenDataStore()
    static let teamDataStore = TeamDataStore()
    static let languageService = LanguageService(userDefaultsStore: userDefaultsStore, dictionaryDataStore: dictionaryDataStore)
    
    static var previews: some View {
        RootContentView()
            .environmentObject(soundService)
            .environmentObject(favoritesService)
            .environmentObject(favoritesProvider)
            .environmentObject(dictionaryDataStore)
            .environmentObject(alphabetDataStore)
            .environmentObject(forKidsDataStore)
            .environmentObject(languageService)
            .environmentObject(teamDataStore)
    }
}
