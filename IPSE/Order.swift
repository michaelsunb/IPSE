//
//  iOrders.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 12/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

class Order : NSManagedObject {
    @NSManaged var identifier: Int
    @NSManaged var qty: Int
    @NSManaged var start_date: String
	@NSManaged var end_date: String
	@NSManaged var toProduct: Product
	@NSManaged var toProfile: Profile
}