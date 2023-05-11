//
//  ForChildrenRootView.swift
//  Movapp (iOS)
//
//  Created by Jakub Ruzicka on 27.10.2022.
//

import SwiftUI

struct ForChildrenRootView: View {

    @EnvironmentObject var languageStore: LanguageStore

    var body: some View {
        NavigationView {
            VStack {
               router
            }
            .navigationTitle(RootItems.for_children.title)
            .background(Color("colors/item"))
        }
        .navigationViewStyle(.stack)
    }

    var images: some View {
        ForChildrenView(selectedLanguage: languageStore.currentLanguage)
    }

    var storiesList: some View {
        StoriesListView(viewModel: StoriesListViewModel(selectedLanguage: languageStore.currentLanguage,
                                                        repository: StoriesRepository()))
    }

    var pexesoView: some View {
        PexesoView(viewModel: PexesoViewModel(repository: PexesoRepository(dataStore: DictionaryDataStore.shared),
                                             soundService: SoundService()))
    }

    var router: some View {
        Section {
            List {
                NavigationLink("for.children.words") {
                    images
                        .navigationTitle("for.children.words")
                }

                NavigationLink("for.children.pexe") {
                    pexesoView
                        .navigationTitle("for.children.pexe")
                }

                if languageStore.currentLanguage == .csUk || languageStore.currentLanguage == .ukCs {
                    NavigationLink("for.children.stories") {
                        storiesList
                            .navigationTitle("for.children.stories")
                    }
                }
            }
        }
        .padding(.top, 1)
    }
}

struct ForChildrenRootView_Previews: PreviewProvider {
    static let userDefaultsStore = UserDefaultsStore()
    static let dictionaryDataStore = DictionaryDataStore.shared
    static let forChildrenDataStore = ForChildrenDataStore(dictionaryDataStore: dictionaryDataStore)
    static let languageStore = LanguageStore(userDefaultsStore: userDefaultsStore,
                                             dictionaryDataStore: dictionaryDataStore,
                                             forChildrenDataStore: forChildrenDataStore)

    static var previews: some View {
        ForChildrenRootView()
            .environmentObject(languageStore)
            .environmentObject(forChildrenDataStore)
    }
}
