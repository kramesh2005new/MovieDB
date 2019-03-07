//
//  MovieListViewTests.swift
//  MovieDBAppUITests
//
//  Created by Ramesh on 07/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import XCTest

class MovieListViewTests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        app = nil
    }

    func testMovieListView() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.buttons["NOW PLAYING"].tap()
        
        let collectionViewsQuery = app.collectionViews
        let cellsQuery = collectionViewsQuery.cells
        let howToTrainYourDragonTheHiddenWorldElement = cellsQuery.otherElements.containing(.staticText, identifier:"How to Train Your Dragon: The Hidden World").element
        howToTrainYourDragonTheHiddenWorldElement.swipeUp()
        
        app.navigationBars["NOW PLAYING"].buttons["Back"].tap()
        app.buttons["POPULAR                "].tap()
        app.navigationBars["POPULAR"].buttons["Back"].tap()
        app.buttons["UPCOMING"].tap()
        
    }

}
