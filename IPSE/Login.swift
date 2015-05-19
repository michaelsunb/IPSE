//
//  iLogin.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 12/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

class Login : iTable {
    @NSManaged var id: Int
    @NSManaged var username: String
    @NSManaged var password: String
    
    override class var getTableName: String { return "Logins" }
}