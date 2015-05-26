//
//  ProfileStruct.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 26/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation

struct Profile {
    var identifier: String
    var first_name: String
    var last_name: String
    var picture: NSData
//    var toLogin: Login = Login()

    init(identifier:String,first_name:String,last_name:String,picture:NSData?) {
        self.identifier = identifier
        self.first_name = first_name
        self.last_name = last_name
        self.picture = picture!
    }
    init(identifier:String,first_name:String,last_name:String) {
        self.identifier = identifier
        self.first_name = first_name
        self.last_name = last_name
        self.picture = NSData()
    }
}