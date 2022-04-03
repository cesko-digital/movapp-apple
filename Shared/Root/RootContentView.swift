//
//  ContentView.swift
//  Shared
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI
import TabBar

struct RootContentView: View {
    
    @State private var selection: RootItems = .dictionary
    @State private var visibility: TabBarVisibility = .visible
    
    var body: some View {
        
        TabBar(selection: $selection, visibility: $visibility) {
            DicitionaryView()
                .tabItem(for: RootItems.dictionary)
            
            AlphabetView()
                .tabItem(for: RootItems.alphabet)
            
            ForChildrenView()
                .tabItem(for: RootItems.for_chidlren)
            
            MenuView()
                .tabItem(for: RootItems.menu)
        }
        .tabBar(style: RootTabBarStyle())
        .tabItem(style: RootTabItemStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootContentView()
    }
}
