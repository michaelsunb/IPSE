//
//  ProductModel.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 15/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData

/**
 * http://www.jessesquires.com/better-coredata-models-in-swift/
 */
class ProductModel : NSManagedObject {
    @NSManaged private var productID : Int
    @NSManaged private var productName : String
    @NSManaged private var productDesc : String
    @NSManaged private var productCost : Float
    @NSManaged private var productImag : String
    
//    var product: [ProductTable] {
//        get {
//            return [ProductTable(
//                id:self.productID,
//                name:self.productName,
//                description:self.productDesc,
//                cost:self.productCost,
//                product_image:self.productImag
//            )]
//        }
//        set {
//            for newVal in newValue {
//                self.productID = newVal.id
//                self.productName = newVal.name
//                self.productDesc = newVal.description
//                self.productCost = newVal.cost
//                self.productImag = newVal.product_image
//            }
//        }
//    }
    
    /**
     * Reference to thread safe singleton at bottom on page
     * http://code.martinrue.com/posts/the-singleton-pattern-in-swift
     */
    class var sharedInstance: ProductModel {
        struct Static {
            static var instance: ProductModel?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ProductModel()
        }
        
        return Static.instance!
    }
}