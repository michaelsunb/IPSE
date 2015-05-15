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
    var itemID: Int
    var ProfileID: Int
    var qty: Int
}