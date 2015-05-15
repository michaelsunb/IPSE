//
//  iProduct.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 15/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation

protocol iProduct{
    func getProducts() -> String
    func getProductDetails() -> String
    func getProductImage(productID:String) -> NSData
}

struct ProductTable {
    var id: Int
    var name: String
    var description: String
    var cost: Float
    var product_image: String
}