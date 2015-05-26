//
//  OrderModel.swift
//  IPSE
//
//  Created by User on 24/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import CoreData
import UIKit

class OrderModel {
    
    var orders:[Order] = [Order]()
    
    func getFirstProduct() -> Order?
    {
        if (orders.count > 0)        {
            return orders[0]
        }
        return nil
    }
    
    func getModel() {
        // Get a reference to your App Delegate
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        // Get a reference to a ManagedObjectContext for interacting with
        // the underlying database
        let managedContext = appDelegate.managedObjectContext!
        
        
        // Retrieve all the records in the table
        let fetchRequest = NSFetchRequest(entityName:"Orders")
        fetchRequest.returnsObjectsAsFaults = false
        
        var error: NSError?
        let fetchedResults:NSArray =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error)!
        
        // Assign the results to the Model
        if fetchedResults.count > 0 {
            for res in fetchedResults {
                println(res)
            }
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    func saveModel(qty:Int,start_date:String,end_date:String,toProduct:Product) {
        // Get a reference to your App Delegate
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        // Get a reference to a ManagedObjectContext for interacting with
        // the underlying database
        let managedContext = appDelegate.managedObjectContext!
        
        // Get a entity from the database that represents the table your are
        // wishing to work with
        let entity: NSManagedObject =  NSEntityDescription.insertNewObjectForEntityForName("Orders", inManagedObjectContext: managedContext) as NSManagedObject
        
        entity.setValue(String(self.orders.count), forKey:"identifier")
        entity.setValue(qty, forKey:"qty")
        entity.setValue(start_date, forKey:"start_date")
        entity.setValue(end_date, forKey:"end_date")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        self.orders.append(Order(identifier:String(self.orders.count),qty:qty,start_date:start_date,end_date:end_date,toProduct:toProduct))
    }
    
    /**
    * Reference to thread safe singleton at bottom on page
    * http://code.martinrue.com/posts/the-singleton-pattern-in-swift
    */
    class var sharedInstance: OrderModel {
        struct Static {
            static var instance: OrderModel?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = OrderModel()
        }
        
        return Static.instance!
    }
}