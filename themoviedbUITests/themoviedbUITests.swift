//
//  themoviedbUITests.swift
//  themoviedbUITests
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import XCTest

class themoviedbUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        
        app = XCUIApplication()
        
        app.launchArguments.append("--uitesting")

    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    // MARK: - Tests
    
    func testAppNavigation() {
        app.launch()
        

        app.swipeUp()
        app.swipeUp()

        app.swipeDown()
        app.swipeDown()
        
        let moviesCell = app.collectionViews.children(matching:.any).element(boundBy: 0)
        if moviesCell.exists {
            moviesCell.swipeLeft()
            moviesCell.swipeRight()
            moviesCell.tap()
        }
        
        app.swipeUp()
        app.swipeUp()

        
        let castCell = app.collectionViews.children(matching:.any).element(boundBy: 0)
        if castCell.exists {
            castCell.swipeLeft()
            castCell.swipeLeft()
            castCell.swipeRight()
        }
        
        app.swipeDown()
        app.swipeDown()

        
        app.buttons["Play Trailer"].tap()

    }
    
}
