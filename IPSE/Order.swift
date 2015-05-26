//
//  iOrders.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 12/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

struct Order {
    var identifier: String
    var qty: Int
    var start_date: String
	var end_date: String
//	var toProduct: Product
//	var toProfile: Profile
    
    init(identifier:String,qty:Int,start_date:String,end_date:String) {
        self.identifier = identifier
        self.qty = qty
        self.start_date = start_date
        self.end_date = end_date
    }
}