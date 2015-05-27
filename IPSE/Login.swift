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
struct Login {
	var identifier: String
	var username: String
	var password: String
	var toProfile: Profile
	
	init(identifier:String,username:String,password:String,toProfile:Profile) {
		self.identifier = identifier
		self.username = username
		self.password = password
		self.toProfile = toProfile
	}
}