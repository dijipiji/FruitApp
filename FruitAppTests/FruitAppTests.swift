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
        let model:Model = Model()
        
        _ = Service.getJSONData(query:Service.baseURL, callback: { (data, error) -> Void in
            
            if error == nil{
        
                let json:[String : Any]? = model.dataToJSON(data!)
                
                if json == nil {
                    XCTAssert(false)
                } else {
                    print("testServiceReturnsJSON, json=\(String(describing: json))")
                    XCTAssert(true)
                }
            }
            
            expectation.fulfill()

        })
        
        wait(for: [expectation], timeout: defaultTimeout)
        
    }
    
    /**
     * test passes if your Service URL returns JSON with "fruit" base node
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
                    let items:[FruitEntity]? = model.parseJSONData(unwrappedJSON)
                    
                    // validate that each FruitEntity object contains data, otherwise assert
                    for item in items ?? [] {
                        if item.type.count == 0 || item.price == nil || item.kgWeight == nil {
                            XCTAssert(false)
                        }
                    }
                    
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
     *
     */
    func testModelPenceToPoundsAndPence() {
        
        let model = Model()
        
        let resultA = model.penceToPoundsAndPence(099)
        
        if resultA != nil {
            XCTAssert(resultA!.pounds==0 && resultA!.pence==99)
        }
        
        let resultB = model.penceToPoundsAndPence(2)
        
        if resultB != nil {
            XCTAssert(resultB!.pounds==0 && resultB!.pence==2)
        }
        
        let resultC = model.penceToPoundsAndPence(1050)
        
        if resultC != nil {
            XCTAssert(resultC!.pounds==10 && resultC!.pence==50)
        }
        
        let resultD = model.penceToPoundsAndPence(100)
        
        if resultD != nil {
            XCTAssert(resultD!.pounds==1 && resultD!.pence==0)
        }
        
    }
    
    
    /**
     *
     */
    func testGramsToKiloGrams() {
        let model = Model()
        
        let resultA = model.gramsToKiloGrams(47)
        
        if resultA != nil {
            XCTAssert(resultA! == 0.047)
        }
        
        let resultB = model.gramsToKiloGrams(120)
        
        if resultB != nil {
            XCTAssert(resultB! == 0.12)
        }
    }
    
    
    /**
     * Tests that the Presenter is hooked up correctly and returns valid items
     */
    func testPresenterPresentsData() {
        
        _ = presenter.getData(callback:{ (data, error) -> Void in
            let items:[FruitEntity]? = self.presenter.presentData(data,error)
            // validate that each FruitEntity object contains data, otherwise assert
            for item in items ?? [] {
                if item.type.count == 0 || item.price == nil || item.kgWeight == nil {
                    XCTAssert(false)
                }
            }
            
        })
        
    }
    
    /**
     *
     */
    func testStatsLogger_Load() {
        let expectation:XCTestExpectation = XCTestExpectation()
        let milliseconds:Int = 2000
        
        _ = Service.sendStats(event:Service.StatType.LOAD, data:milliseconds, callback:{ (data, error) -> Void in
            
            if error == nil {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
            
            expectation.fulfill()
            
        })
        
        wait(for: [expectation], timeout: defaultTimeout)
        
    }
    
    /**
     *
     */
    func testStatsLogger_Display() {
        let expectation:XCTestExpectation = XCTestExpectation()
        let milliseconds:Int = 2000
        
        _ = Service.sendStats(event:Service.StatType.DISPLAY, data:milliseconds, callback:{ (data, error) -> Void in
            
            if error == nil {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
            
            expectation.fulfill()
            
        })
        
        wait(for: [expectation], timeout: defaultTimeout)
        
    }
    
    /**
     *
     */
    func testStatsLogger_Error() {
        let expectation:XCTestExpectation = XCTestExpectation()
        let description:String = "Application crashed at line \(#line), function \(#function) of \(#file)"
        
        _ = Service.sendStats(event:Service.StatType.ERROR, data:description, callback:{ (data, error) -> Void in
            
            if error == nil {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
            
            expectation.fulfill()
            
        })
        
        wait(for: [expectation], timeout: defaultTimeout)
        
    }
    


}
