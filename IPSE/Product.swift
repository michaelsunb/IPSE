//
//  iProduct.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 15/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

class Product : iTable {
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var desc: String
    @NSManaged var cost: Float
    @NSManaged var product_image: String
    
    override class var getTableName: String { return "Products" }

    override func getId() -> Int {
        return self.id
    }
    
    override func newEntry(table:iTable) {
        let newProductEntry:Product = table as Product
        self.id = newProductEntry.id
        self.name = newProductEntry.name
        self.desc = newProductEntry.desc
        self.cost = newProductEntry.cost
        self.product_image = newProductEntry.product_image
        
//        context.setValue(self.id, forKey: "id")
//        context.setValue(self.name, forKey: "name")
//        context.setValue(self.desc, forKey: "desc")
//        context.setValue(self.cost, forKey: "cost")
//        context.setValue(self.product_image, forKey: "product_image")
    }
}