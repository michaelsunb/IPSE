//
//  iOrders.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 12/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

class Order : iTable {
    @NSManaged var id: Int
    @NSManaged var item_id: Int
    @NSManaged var profile_id: Int
    @NSManaged var qty: Int
    @NSManaged var start_date: String
    @NSManaged var end_date: String

    override class var getTableName: String { return "Orders" }
}