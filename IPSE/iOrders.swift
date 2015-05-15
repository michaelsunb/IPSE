//
//  iOrders.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 12/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation

protocol iOrders {
    func createOrder() -> Bool
    func updateOrder() -> Bool
    func removeOrder() -> Bool
    
    func getOrders() -> [OrderTable]
}

struct OrderTable {
    var id: Int
    var item_id: Int
    var profile_id: Int
    var qty: Int
    var start_date: String
    var end_date: String
}