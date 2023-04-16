//
//  RootContentView.swift
//  WatchMovapp WatchKit Extension
//
//  Created by Daryna Polevyk on 22.04.2022.
//

import SwiftUI

struct RootContentView: View {

    var body: some View {
        ScrollView {
            LazyVStack {
                NavigationLink {
                    DictionaryView(viewModel: DictionaryViewModel(
                        dataStore: DictionaryDataStore.shared,
                        language: LanguageProvider.shared.language)
                    )
                    .navigationTitle(RootItems.dictionary.title)
                } label: {
                    RootItemView(imageName: RootItems.dictionary.icon, title: RootItems.dictionary.title)
                }

                NavigationLink {
                    AlphabetView(viewModel: AlphabetViewModel(
                        dataStore: AlphabetDataStore(),
                        language: LanguageProvider.shared.language)
                    )
                    .navigationTitle(RootItems.alphabet.title)
                } label: {
                    RootItemView(imageName: RootItems.alphabet.icon, title: RootItems.alphabet.title)
                }

                NavigationLink {
                    ForChildrenView(viewModel: ForChildrenViewModel(
                        dataStore: ForChildrenDataStore(dictionaryDataStore: DictionaryDataStore.shared),
                        dictionaryDataStore: DictionaryDataStore.shared,
                        language: LanguageProvider.shared.language)
                    )
                    .navigationTitle(RootItems.for_children.title)
                } label: {
                    RootItemView(imageName: RootItems.for_children.icon, title: RootItems.for_children.title)
                }
            }
            .padding(8)
        }
    }
}

struct RootContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootContentView()
    }
}
