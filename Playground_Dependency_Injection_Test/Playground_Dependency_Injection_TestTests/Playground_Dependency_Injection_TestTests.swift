//
//  Playground_Dependency_Injection_TestTests.swift
//  Playground_Dependency_Injection_TestTests
//
//  Created by Romuald Brochard on 13/04/2019.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//

import XCTest
@testable import Playground_Dependency_Injection_Test

class Playground_Dependency_Injection_TestTests: XCTestCase {

    var controllerUnderTest: ViewController!
    var mockService: Service!
    var mockServiceVoid: Service!

    class MockService: Service{
        func load() -> [String] {
            return ["111", "222", "333", "444", "555"]
        }
    }
    
    class MockServiceVoid: Service{
        func load() -> [String] {
            return []
        }
    }
    
    override func setUp() {
        controllerUnderTest = (UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController)
        let _ = controllerUnderTest.view // To trigger viewDidLoad
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMockFive() {
        mockService = MockService()
        controllerUnderTest.service = mockService
        controllerUnderTest.tableView.reloadData()
        XCTAssert(controllerUnderTest.tableView.numberOfRows(inSection: 0) == 5 )
    }
    
    func testMockZero() {
        mockServiceVoid = MockServiceVoid()
        controllerUnderTest.service = mockServiceVoid
        controllerUnderTest.tableView.reloadData()
        XCTAssert(controllerUnderTest.tableView.numberOfRows(inSection: 0) == 0 )
    }


}
