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
    
    let instances1 : Model = Model.sharedInstance
    let instances2 : Model = Model.sharedInstance
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetProductsTable() {
        let products = self.instances1.getTable("Products") as [Product]

        for product in products {
            XCTAssertGreaterThanOrEqual(product.getId(), 0,
                "Table name should be Products")
        }
    }
    
//    func testSaveModel() {
//        var newProduct = Product()
//        newProducts.id = 0
//        newProducts.name = "test name"
//        newProducts.desc = "test desc"
//        newProducts.cost = 5.90
//        newProducts.product_image = "test img"
//        instances1.save(newProducts)
//    }
    
    func testSharedInstance_Twice() {
        let inst1 = instances1
        let inst2 = instances2
        XCTAssertTrue(inst1 === inst2, "Instances should be the same")
    }
}
