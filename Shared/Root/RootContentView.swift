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
            let icon = item.icon

            if icon.contains("icons/") {
                Label(item.title, image: icon)
            } else {
                Label(item.title, systemImage: icon)
            }

        }.tag(item)
    }
}

struct RootContentView: View {
    @EnvironmentObject var languageStore: LanguageStore

    var body: some View {
        ZStack(alignment: .top) {

            TabView {
                DictionaryView(selectedLanguage: languageStore.currentLanguage)
                    .setTabItem(RootItems.dictionary)

                AlphabetView(viewModel: AlphabetViewModel(dataStore: AlphabetDataStore(), languageStore: languageStore))
                    .setTabItem(RootItems.alphabet)

                ForChildrenRootView()
                    .setTabItem(RootItems.for_children)

                MenuView(viewModel: MenuViewModel(selectedLanguage: languageStore.currentLanguage,
                                                  languageStore: languageStore))
                    .setTabItem(RootItems.settings)
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
    static let dictionaryDataStore = DictionaryDataStore.shared
    static let favoritesService = PhraseFavoritesService(userDefaultsStore: userDefaultsStore,
                                                         dictionaryDataStore: dictionaryDataStore)
    static let favoritesProvider = PhrasesFavoritesProvider(favoritesService: favoritesService)
    static let forChildrenDataStore = ForChildrenDataStore(dictionaryDataStore: dictionaryDataStore)
    static let teamDataStore = TeamDataStore()
    static let languageStore = LanguageStore(userDefaultsStore: userDefaultsStore,
                                             dictionaryDataStore: dictionaryDataStore,
                                             forChildrenDataStore: forChildrenDataStore)

    static var previews: some View {
        RootContentView()
            .environmentObject(soundService)
            .environmentObject(favoritesService)
            .environmentObject(favoritesProvider)
            .environmentObject(dictionaryDataStore)
            .environmentObject(forChildrenDataStore)
            .environmentObject(languageStore)
            .environmentObject(teamDataStore)
    }
}
