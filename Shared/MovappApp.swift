//
//  MovappApp.swift
//  Shared
//
//  Created by Martin Kluska on 02.04.2022.
//

import SwiftUI

@main
struct MovappApp: App {
    
    let soundService = SoundService()
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear // gets also rid of the bottom border of the navigation bar
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Color("colors/primary"))
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    

    var body: some Scene {
        WindowGroup {
            RootContentView()
                .environmentObject(soundService)
        }
    }
}
