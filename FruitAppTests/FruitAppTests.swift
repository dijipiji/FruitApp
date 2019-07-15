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
        
        // note this doesn't pass as a URL, but "this_is_an_unsupported_url" does pass - see testUnsupportedServiceURL() later
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
        
        let myURL:String = "this_is_an_unsupported_url_which_initially_passes_as_valid"
        
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
                    print("testServiceReturnsJSON, json=\(String(describing: json))")
                    XCTAssert(true)
                } catch let error {
                    print("testServiceReturnsJSON, error=\(error.localizedDescription)")
                    XCTAssert(false)
                }
            }
            
            expectation.fulfill()

        })
        
        wait(for: [expectation], timeout: defaultTimeout)
        
    }
    
    /**
     *
     */
    func testJSONContainsFruitAsBaseNode() {
        let expectation:XCTestExpectation = XCTestExpectation()
        
        _ = Service.getJSONData(query:Service.baseURL, callback: { (data, error) -> Void in
            
            if error == nil {
                do {
                    let json:[String : Any]? = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                    
                    guard let unwrappedJSON:[String : Any] = json else {
                        return
                    }
                    
                    let myNodeName:String = "fruit"
                    
                    if unwrappedJSON[myNodeName] != nil {
                        XCTAssert(true)
                    } else {
                        XCTAssert(false, "The base JSON node isn't identified as \(myNodeName)")
                    }
                    
                } catch let error {
                    print("testJSONContainsFruitAsBaseNode, error=\(error.localizedDescription)")
                    XCTAssert(false)
                }
            }
            
            expectation.fulfill()
            
        })
        
        wait(for: [expectation], timeout: defaultTimeout)
    }
    
    /**
     *
     */
    func testJSONMatchesExpectedSchema() {
        
        let expectation:XCTestExpectation = XCTestExpectation()
        
        _ = Service.getJSONData(query:Service.baseURL, callback: { (data, error) -> Void in
            
            if error == nil {
                do {
                    let json:[String : Any]? = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                    
                    guard let unwrappedJSON:[String : Any] = json else {
                        return
                    }
                    
                    let myNodeName:String = "fruit"
                    
                    if unwrappedJSON[myNodeName] != nil {
                        
                        let list:[Any?] = unwrappedJSON[myNodeName] as! [Any?]

                        let _:[[String:Any]?] = list.map { (item) in
                            
                            let itemCasted:[String:Any]? = item as? [String:Any]
                            
                            if itemCasted == nil { // then the schema is broken
                                XCTAssert(false, "A node doesn't match the schema")
                            }

                            return itemCasted
                        }
   
                    } else {
                        XCTAssert(false, "The base JSON node isn't identified as \(myNodeName)")
                    }
                    
                } catch let error {
                    print("testJSONContainsFruitAsBaseNode, error=\(error.localizedDescription)")
                    XCTAssert(false)
                }
            }
            
            expectation.fulfill()
            
        })
        
        wait(for: [expectation], timeout: defaultTimeout)
        
    }
    
    /**
     *
     */
    func testModelJSONParser() {
        let expectation:XCTestExpectation = XCTestExpectation()
        
        _ = Service.getJSONData(query:Service.baseURL, callback: { (data, error) -> Void in
            
            if error == nil {
                do {
                    let json:[String : Any]? = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                    
                    guard let unwrappedJSON:[String : Any] = json else {
                        return
                    }
                    
                    let model:Model = Model()
                    model.parseJSONData(unwrappedJSON)
                    XCTAssert(true)
                    
                } catch let error {
                    print("testModelParser, error=\(error.localizedDescription)")
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
