//
//  FastlaneSnapshot.swift
//  MovappUITests
//
//  Created by Martin Kluska on 02.05.2022.
//

import XCTest

class FastlaneSnapshot: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state
        // - such as interface orientation
        // - required for your tests before they run.
        // The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        setupSnapshot(app)

        app.setSeenOnBoarding(true)
        app.disableSetIcon()

        app.launch()
        snapshot("1 - Dictionary")

        app.scrollViews.otherElements.staticTexts["dictionary_0"].tap()
        snapshot("1 - Dictionary detail")

        app.tabBars.buttons.element(boundBy: 1).tap()
        snapshot("2 - Alphabet")

        app.tabBars.buttons.element(boundBy: 2).tap()
        snapshot("3 - For Children")

        app.collectionViews.buttons.element(boundBy: 0).tap()
        snapshot("3.1 - For Children - Alphabet")

        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.collectionViews.buttons.element(boundBy: 1).tap()
        snapshot("3.2 - For Children - Pexeso")

        app.navigationBars.buttons.element(boundBy: 0).tap()
        if app.collectionViews.buttons.element(boundBy: 2).exists {
            app.collectionViews.buttons.element(boundBy: 2).tap()
            snapshot("3.3 - For Children - Stories")
        }

        app.tabBars.buttons.element(boundBy: 3).tap()
        snapshot("4 - Menu")
    }
}
