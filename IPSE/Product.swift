//
//  iProduct.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 15/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

class Product : NSManagedObject {
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var desc: String
    @NSManaged var cost: Float
    @NSManaged var product_image: String
}