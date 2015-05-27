//
//  IPSE.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 26/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

struct Product {
	var identifier: String
	var cost: Int
	var desc: String
	var name: String
	var product_image: NSData
	
	init(identifier:String,name:String,cost:Int,desc:String,picture:NSData?) {
		self.identifier = identifier
		self.name = name
		self.cost = cost
		self.desc = desc
		self.product_image = picture!
	}
	init(identifier:String,name:String,cost:Int,desc:String) {
		self.identifier = identifier
		self.name = name
		self.cost = cost
		self.desc = desc
		self.product_image = NSData()
	}
}
