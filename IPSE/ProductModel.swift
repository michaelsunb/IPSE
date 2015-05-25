//
//  ProductModel.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 15/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/**
 * http://www.jessesquires.com/better-coredata-models-in-swift/
 */
class ProductModel {
    
    var products:[Product] = [Product]()
    var productsTest:[ProductTest]
    
    init() {
        //loadTable()
        productsTest = [ProductTest(id:0,name:"name1",desc:"desc1",cost:(4.20) as Float, product_image:"Terminator"),
        ProductTest(id:1,name:"name2",desc:"this will be a picture about avengers",cost:(1.23) as Float,product_image:"Avengers"),
        ProductTest(id:2,name:"name3",desc:"test3",cost:6.66,product_image:"Fifty Shades of Grey")]
    }
    
    func getProductTest()->[ProductTest] {
        return self.productsTest
    }
    
    func getTable() -> [Product] {
        if(products.count > 0) {
            return products
        }
        loadTable()
        
        return products
    }
    
    func getFirstProduct() -> Product? {
        if (products.count > 0) {
            return products[0]
        }
        return nil
    }
    
    private func loadTable() {
        // Get a reference to your App Delegate
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        // Get a reference to a ManagedObjectContext for interacting with
        // the underlying database
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Products")

        var error: NSError?

        let fetchedResults : [Product] =
            managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [Product]

        // Assign the results to the Model
        if fetchedResults.count > 0 {
            products = fetchedResults
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    func saveProduct(id: Int, name: String, desc:String,
        cost:Float, product_image:String, existing: Product?)
    {
        // Get a reference to your App Delegate
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        // Get a reference to a ManagedObjectContext for interacting with
        // the underlying database
        let managedContext = appDelegate.managedObjectContext!
        
        // Get a entity from the database that represents the table your are
        // wishing to work with
        let entity =  NSEntityDescription.entityForName("Products",
            inManagedObjectContext:
            managedContext)
        
        if((existing) == nil)
        {
            // Create an object based on the Entity
            let product = Product(entity: entity!,
                insertIntoManagedObjectContext:managedContext)
            product.id = id
            product.name = name
            product.desc = desc
            product.cost = cost
            product.product_image = product_image
            self.products.append(product)
        }
        else
        {
            existing!.id = id
            existing!.name = name
            existing!.desc = desc
            existing!.cost = cost
            existing!.cost = cost
            existing!.product_image = product_image
        }
        
        // Check for errors and save
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
    
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