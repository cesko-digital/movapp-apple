//
//  MovappApp.swift
//  WatchMovapp WatchKit Extension
//
//  Created by Daryna Polevyk on 22.04.2022.
//

import SwiftUI

@main
struct MovappApp: App {

    @State private var language: SetLanguage?

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if language == nil {
                    OnboardingView()
                } else {
                    RootContentView()
                }
            }
            .onReceive(LanguageProvider.shared.$language) { language in
                self.language = language
            }
        }
    }
}
