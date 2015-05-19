//
//  iFavourite.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 15/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

class Favourite : iTable {
    @NSManaged var id: Int
    @NSManaged var profile_id: Int
    @NSManaged var order_id: Int
    
    override class var getTableName: String { return "Favourites" }
}