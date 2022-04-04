//
//  ContentView.swift
//  Shared
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

struct RootContentView: View {
    var body: some View {
        
        TabView {
            DicitionaryView()
                .tabItem {
                    Text(RootItems.dictionary.title)
                }
            
            AlphabetView()
                .tabItem {
                    Text(RootItems.alphabet.title)
                }
            
            ForChildrenView()
                .tabItem {
                    Text(RootItems.for_chidlren.title)
                }
            
            MenuView()
                .tabItem {
                    Text(RootItems.menu.title)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootContentView()
    }
}
