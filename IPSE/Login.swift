//
//  iLogin.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 12/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

/**
 * https://www.youtube.com/watch?v=K6PfveuxUEk
 */
class Login : NSManagedObject {
    @NSManaged var identifier: String
    @NSManaged var username: String
    @NSManaged var password: String
	@NSManaged var profile_id: String
	@NSManaged var toProfile: Profile
}