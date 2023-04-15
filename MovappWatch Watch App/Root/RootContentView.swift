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
                        dataStore: DictionaryDataStore(),
                        userDefaults: UserDefaultsStore())
                    )
                    .navigationTitle(RootItems.dictionary.title)
                } label: {
                    RootItemView(imageName: RootItems.dictionary.icon, title: RootItems.dictionary.title)
                }
                #if DEBUG
                NavigationLink {
                    AlphabetView()
                        .navigationTitle(RootItems.alphabet.title)
                } label: {
                    RootItemView(imageName: RootItems.alphabet.icon, title: RootItems.alphabet.title)
                }

                NavigationLink {
                    ForChildrenView()
                        .navigationTitle(RootItems.for_children.title)
                } label: {
                    RootItemView(imageName: RootItems.for_children.icon, title: RootItems.for_children.title)
                }
                #endif
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