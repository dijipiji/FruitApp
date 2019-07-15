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
    let defaultTimeout:Double = 5.0

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
        
        // note this parses as a URL, but "this_is_an_unsupported_url" does parse - see testUnsupportedServiceURL() later
        let myURL:String = "this is not a valid URL"
        
        let validURL:Bool = Service.getJSONData(query:myURL, callback: { (data, error) -> Void in })
        
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
        
        let validURL:Bool = Service.getJSONData(query:Service.baseURL, callback: { (data, error) -> Void in })
        
        if validURL {
            XCTAssert(true)
        } else {
            XCTAssert(false, "The Service hasn't recognised a valid URL!")
        }
    }
    
    /**
     * test passes if your Service URL is an unsupported URL
     */
    func testUnsupportedServiceURL() {
        
        let expectation:XCTestExpectation = XCTestExpectation()
        
        let myURL:String = "this_is_an_unsupported_url_which_initially_parses_as_valid"
        
        let validURL:Bool = Service.getJSONData(query:myURL, callback: { (data, error) -> Void in
            
            if error != nil {
                print("testUnsupportedServiceURL, error=\(error!.localizedDescription)")
                XCTAssert(true)
            } else {
                XCTAssert(false, "The Service hasn't recognised a non-URL!")
            }
            
            expectation.fulfill()
            
        })
        
        if !validURL {
            XCTAssert(true)
        } else {
            wait(for: [expectation], timeout: defaultTimeout)
        }
        
    }
    
    /**
     * test passes if your Service URL returns JSON
     */
    func testServiceReturnsJSON() {
        
        let expectation:XCTestExpectation = XCTestExpectation()
        
        _ = Service.getJSONData(query:Service.baseURL, callback: { (data, error) -> Void in
            
            if error == nil {
                do {
                    let json:[String : Any]? = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                    print("json=\(String(describing: json))")
                    XCTAssert(true)
                } catch let error {
                    print("error=\(error.localizedDescription)")
                    XCTAssert(false)
                }
            }
            
            expectation.fulfill()

        })
        
        wait(for: [expectation], timeout: defaultTimeout)
        
    }
    
    
    /**
     * test passes if your Service URL returns JSON with "fruit" base node
     */

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
