//
//  MovappUITests.swift
//  MovappUITests
//
//  Created by Martin Kluska on 02.05.2022.
//

import XCTest

class MovappUITests: XCTestCase {

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

    func testHomescreen() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.setSeenOnBoarding(true)
        app.disableSetIcon()

        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.

        app.tabBars.buttons.element(boundBy: 0).tap()

        app.scrollViews.otherElements.staticTexts["dictionary_0"].tap()

        app.tabBars.buttons.element(boundBy: 1).tap()
        app.tabBars.buttons.element(boundBy: 2).tap()
        app.tabBars.buttons.element(boundBy: 3).tap()
    }

    func assertOnBoarding(_ app: XCUIApplication) throws {
        app.setSeenOnBoarding(false)
        app.disableSetIcon()

        app.launch()

        app.buttons["welcome-ukrainian"].tap()
        app.buttons["toLearn-czech"].tap()

        app.collectionViews["tutorial-tab-view"].swipeLeft()

        app.buttons["welcome-go-start"].tap()
        app.buttons["on_boarding_back"].tap()

        app.buttons["welcome-czech"].tap()

        app.collectionViews["tutorial-tab-view"].swipeLeft()

        app.buttons["start-learning-button"].tap()

        app.tabBars.buttons.element(boundBy: 0).tap()

        app.scrollViews.otherElements.staticTexts["dictionary_0"].tap()
    }

    func testOnBoardingUk() throws {
        let app = XCUIApplication()
        app.setLanguageToUk()

        try assertOnBoarding(app)
    }

    func testOnBoardingCs() throws {
        let app = XCUIApplication()
        app.setLanguageToCs()

        try assertOnBoarding(app)
    }

    func testOnBoardingEn() throws {
        let app = XCUIApplication()
        app.setLanguageToEn()

        try assertOnBoarding(app)
    }
}
