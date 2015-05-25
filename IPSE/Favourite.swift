//
//  Favourites.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 26/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

class Favourite: NSManagedObject {
    @NSManaged var identifier: String
    @NSManaged var toProfile: Profile
    @NSManaged var toProduct: Product
}
