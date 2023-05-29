//
//  MovappWatchUITests.swift
//  MovappWatchUITests
//
//  Created by Jakub Ruzicka on 15.05.2023.
//

import XCTest

final class MovappWatchUITests: XCTestCase {

    func testFastlaneSnapshots() throws {
        let app = XCUIApplication()
        setupSnapshot(app)

        app.launch()
        snapshot("1 - Root")

        app.buttons.element(boundBy: 0).tap()
        snapshot("2 - Dictionary")

        app.buttons.element(boundBy: 1).tap()
        snapshot("2.1 - Dictionary - Basic phrases")

        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()

        app.buttons.element(boundBy: 1).tap()
        snapshot("3 - Alphabet")

        app.buttons.element(boundBy: 1).tap()
        snapshot("3.1 - Alphabet Detail")

        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()

        app.swipeUp()

        app.buttons.element(boundBy: 2).tap()
        snapshot("4 - Children")
    }
}
