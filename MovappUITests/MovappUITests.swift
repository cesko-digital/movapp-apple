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

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        app.tabBars.buttons.element(boundBy: 0).tap()
        
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["dictionary_0"]/*[[".staticTexts[\"Základní fráze - Основні фрази\"]",".staticTexts[\"dictionary_0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        app.tabBars.buttons.element(boundBy: 1).tap()
        app.tabBars.buttons.element(boundBy: 2).tap()
        app.tabBars.buttons.element(boundBy: 3).tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
