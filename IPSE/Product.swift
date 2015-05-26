//
//  IPSE.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 26/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

class Product: NSManagedObject {

    @NSManaged var cost: NSNumber
    @NSManaged var desc: String
    @NSManaged var identifier: String
    @NSManaged var name: String
    @NSManaged var product_image: NSData
//    @NSManaged var toFavourite: Favourite
}
