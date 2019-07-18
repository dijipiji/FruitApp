//
//  FruitAppUITests.swift
//  FruitAppUITests
//
//  Created by Jamie Lemon on 15/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import XCTest

class FruitAppUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testReload() {
        
        let reloadButton = app.navigationBars["Fruits"].buttons["Refresh"]
        XCTAssertTrue(reloadButton.exists)
        
        reloadButton.tap()
        
    }

    func testScreens() {
        
        var cell = app.collectionViews.staticTexts["apple"]
        XCTAssertTrue(cell.exists)
        cell.tap()
        
        let back = app.navigationBars["Fruit"].buttons["Fruits"]
        XCTAssertTrue(back.exists)
        back.tap()
        
        cell = app.collectionViews.staticTexts["banana"]
        XCTAssertTrue(cell.exists)
        cell.tap()
        XCTAssertTrue(back.exists)
        back.tap()
        
        cell = app.collectionViews.staticTexts["blueberry"]
        XCTAssertTrue(cell.exists)
        cell.tap()
        XCTAssertTrue(back.exists)
        back.tap()
        
        cell = app.collectionViews.staticTexts["orange"]
        XCTAssertTrue(cell.exists)
        cell.tap()
        XCTAssertTrue(back.exists)
        back.tap()
        
        cell = app.collectionViews.staticTexts["pear"]
        XCTAssertTrue(cell.exists)
        cell.tap()
        XCTAssertTrue(back.exists)
        back.tap()
        
        cell = app.collectionViews.staticTexts["strawberry"]
        XCTAssertTrue(cell.exists)
        cell.tap()
        XCTAssertTrue(back.exists)
        back.tap()
        
        cell = app.collectionViews.staticTexts["kumquat"]
        XCTAssertTrue(cell.exists)
        cell.tap()
        XCTAssertTrue(back.exists)
        back.tap()
        
        cell = app.collectionViews.staticTexts["pitaya"]
        XCTAssertTrue(cell.exists)
        cell.tap()
        XCTAssertTrue(back.exists)
        back.tap()
        
        cell = app.collectionViews.staticTexts["kiwi"]
        XCTAssertTrue(cell.exists)
        cell.tap()
        XCTAssertTrue(back.exists)
        back.tap()
        
    }
    
    func testZoomUI() {
        
        let zoomInButton = app.buttons["+"]
        XCTAssertTrue(zoomInButton.exists)
        zoomInButton.tap()
        zoomInButton.tap()
        zoomInButton.tap()
        
        let zoomOutButton = app.buttons["-"]
        XCTAssertTrue(zoomOutButton.exists)
        zoomOutButton.tap()
        zoomOutButton.tap()
        zoomOutButton.tap()
        zoomOutButton.tap()
        zoomOutButton.tap()
        zoomOutButton.tap()
        zoomOutButton.tap()
        zoomOutButton.tap()
        zoomOutButton.tap()
        zoomInButton.tap()
        zoomInButton.tap()
        zoomInButton.tap()
        zoomInButton.tap()
        zoomInButton.tap()
        zoomInButton.tap()
    
    }
    
    func testOrientationChanges() {
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .landscapeLeft
        
        let app = XCUIApplication()
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["blueberry"]/*[[".cells.staticTexts[\"blueberry\"]",".staticTexts[\"blueberry\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .landscapeLeft
        XCUIDevice.shared.orientation = .portraitUpsideDown
        XCUIDevice.shared.orientation = .landscapeRight
        XCUIDevice.shared.orientation = .portraitUpsideDown
        XCUIDevice.shared.orientation = .landscapeLeft
        app.navigationBars["Fruit"].buttons["Fruits"].tap()
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .landscapeRight
        XCUIDevice.shared.orientation = .portraitUpsideDown
        XCUIDevice.shared.orientation = .landscapeRight
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .landscapeLeft
        
        
    }

}
