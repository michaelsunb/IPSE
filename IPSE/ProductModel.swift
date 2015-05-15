//
//  ProductModel.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 15/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

// http://
// www.jessesquires.com/better-coredata-models-in-swift/
class ProductModel : NSManagedObject {
    @NSManaged private var productID : Int
    @NSManaged private var productName : String
    @NSManaged private var productDesc : String
    @NSManaged private var productCost : Float
    @NSManaged private var productImag : String
    
    var product: ProductTable {
        get {
            return ProductTable(
                id:self.productID,
                name:self.productName,
                description:self.productDesc,
                cost:self.productCost,
                product_image:self.productImag
            )
        }
        set {
            self.productID = newValue.id
            self.productName = newValue.name
            self.productDesc = newValue.description
            self.productCost = newValue.cost
            self.productImag = newValue.product_image
        }
    }
}