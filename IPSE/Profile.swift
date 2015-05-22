//
//  iProfile.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 12/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

class Profile : NSManagedObject {
    @NSManaged var id: Int
    @NSManaged var first_name: String
    @NSManaged var last_name: String
    @NSManaged var picture: String
}