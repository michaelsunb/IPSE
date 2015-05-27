//
//  Products.swift
//  IPSE
//
//  Created by Monster on 25/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation


class Products {
	var productID:Int
	var productName:String
	var description:String
	var cost:Int
	init (productID:Int, name:String,description:String,cost:Int) {
		self.productID = productID
		self.productName = name
		self.description = description
		self.cost = cost
	}
	
	func getID()->Int{
		return productID
	}
	func getName()->String{
		return productName
	}
	func getDescription()->String{
		return description
	}
	func getCost()->Int {
		return cost
	}
	
}