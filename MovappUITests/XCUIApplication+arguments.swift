//
//  XCUIApplication+arguments.swift
//  MovappUITests
//
//  Created by Martin Kluska on 04.05.2022.
//

import XCTest

extension XCUIApplication {
    
    func setSeenOnBoarding(_ seen: Bool = true) {
        // The key must be se same as user default key
        launchArguments += ["-onboarding.complete", seen ? "true" : "false"]
    }
    
    func setLanguageTo(_ languageKey: String) {
        launchArguments += ["-AppleLanguages", "(\(languageKey))"]
        
        let localKey = languageKey.replacingOccurrences(of: "-", with: "_")
        launchArguments += ["-AppleLocale", "\"\(localKey)\""]
    }
    
    func setLanguageToUk() {
        setLanguageTo("uk")
    }
    
    func setLanguageToEn() {
        setLanguageTo("en-US")
    }
    
    func setLanguageToCs() {
        setLanguageTo("uk")
    }
}
