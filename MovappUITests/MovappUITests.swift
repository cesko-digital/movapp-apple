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
    
    func testHomescreen() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        
        app.setSeenOnBoarding(true)
        
        app.launch()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        app.tabBars.buttons.element(boundBy: 0).tap()
        
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["dictionary_0"]/*[[".staticTexts[\"Základní fráze - Основні фрази\"]",".staticTexts[\"dictionary_0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        app.tabBars.buttons.element(boundBy: 1).tap()
        app.tabBars.buttons.element(boundBy: 2).tap()
        app.tabBars.buttons.element(boundBy: 3).tap()
    }
    
    
    
    func assertOnBoarding(_ app: XCUIApplication) throws {
        app.setSeenOnBoarding(false)
        
        app.launch()

        app.buttons["welcome-ukrainian"].tap()
        app.buttons["toLearn-czech"].tap()
        
        app.collectionViews["tutorial-tab-view"].swipeLeft()
        
        app/*@START_MENU_TOKEN@*/.buttons["welcome-go-start"]/*[[".buttons[\"Zpět\"]",".buttons[\"welcome-go-start\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["on_boarding_back"].tap()

        app.buttons["welcome-czech"].tap()
        
        
        app.collectionViews["tutorial-tab-view"].swipeLeft()
        
        app/*@START_MENU_TOKEN@*/.buttons["start-learning-button"]/*[[".buttons[\"Začít s účením\"]",".buttons[\"start-learning-button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tabBars.buttons.element(boundBy: 0).tap()
        
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["dictionary_0"]/*[[".staticTexts[\"Základní fráze - Основні фрази\"]",".staticTexts[\"dictionary_0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
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
