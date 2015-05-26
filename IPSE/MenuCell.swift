//
//  MenuCell.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 26/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import UIKit

struct MenuCell {
    var id:Int
    var title:String
    var qty:Int
    //	var price:Int
    
    init(id:Int,title:String,qty:Int) {
        self.id = id
        self.title = title
        self.qty = qty
        //		self.price = price
    }
}
