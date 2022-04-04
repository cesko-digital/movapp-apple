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
    var body: some View {
        TabView {
            DicitionaryView()
                .setTabItem(RootItems.dictionary)
            
            AlphabetView()
                .setTabItem(RootItems.alphabet)
            
            ForChildrenView()
                .setTabItem(RootItems.for_chidlren)
            
            MenuView()
                .setTabItem(RootItems.menu)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootContentView()
    }
}
