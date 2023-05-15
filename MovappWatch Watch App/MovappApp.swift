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

    init() {
        // Restoring application language from locale based on Fastlane snapshots
        if let appleLocale = UserDefaults.standard.string(forKey: "AppleLocale") {
            LanguageProvider.shared.language = getSetLanguage(for: appleLocale)
            NSLog("Restored language from arguments: \(appleLocale)")
        }
    }

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
