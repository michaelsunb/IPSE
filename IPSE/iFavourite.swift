//
//  iFavourite.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 15/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation

protocol iFavourite{
    func getFirstName() -> String
    func getLastName() -> String
    func getProfilePic() -> String
}

struct FavouriteTable {
    var id: Int
    var profile_id: Int
    var order_id: Int
}