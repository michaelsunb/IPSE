//
//  ProductTest.swift
//  IPSE
//
//  Created by User on 24/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation

struct ProductTest {
    var id: Int
    var name: String
    var desc: String
    var cost: Float
    var product_image: String
    
    init(id:Int,name:String,desc:String,cost:Float,product_image:String) {
        self.id = id
        self.name = name
        self.desc = desc
        self.cost = cost
        self.product_image = product_image
    }
}