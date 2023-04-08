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
                    DictionaryView()
                } label: {
                    RootItemView(imageName: RootItems.dictionary.icon, title: RootItems.dictionary.title)
                }

                NavigationLink {
                    AlphabetView()
                } label: {
                    RootItemView(imageName: RootItems.alphabet.icon, title: RootItems.alphabet.title)
                }

                NavigationLink {
                    ForChildrenView()
                } label: {
                    RootItemView(imageName: RootItems.for_chidlren.icon, title: RootItems.for_chidlren.title)
                }
            }
        }
    }
}

struct RootContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootContentView()
    }
}
