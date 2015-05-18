//
//  IPSETests.swift
//  IPSETests
//
//  Created by Michaelsun Baluyos on 12/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import UIKit
import XCTest

class IPSETests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testProductModel() {
        var test = ProductModel()
//        test.product = ProductTable(id: 0,name: "in name",description: "in desc",cost: 4.20,product_image: "in image")
//        XCTAssertEqual(test.product.id,0, "ID should equal to zero")
    }
}
