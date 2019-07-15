//
//  FruitAppTests.swift
//  FruitAppTests
//
//  Created by Jamie Lemon on 15/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import XCTest
@testable import FruitApp

class FruitAppTests: XCTestCase {
    
    let presenter:Presenter = Presenter()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /**
     * test passes if your Service URL is a non-URL
     */
    func testInvalidServiceURL() {

        let validURL:Bool = presenter.getData(query:"this_is_not_a_url", callback:{ (data, error) -> Void in })
        
        if !validURL {
            XCTAssert(true)
        } else {
            XCTAssert(false, "The Service hasn't recognised a non-URL!")
        }
        
    }

    /**
     * test passes if your Service URL is a valid URL
     */
    func testValidServiceURL() {
        
        let validURL:Bool = presenter.getData(query:"http://bbc.com", callback:{ (data, error) -> Void in })
        
        if validURL {
            XCTAssert(true)
        } else {
            XCTAssert(false, "The Service hasn't recognised a valid URL!")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
