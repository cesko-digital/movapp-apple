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
}
