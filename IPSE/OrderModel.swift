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
    
    init() {
        loadTable()
    }
    
    func getTable() -> [Order] {
        if(orders.count > 0) {
            return orders
        }
        loadTable()
        
        return orders
    }
    
    func getFirstProduct() -> Order?
    {
        if (orders.count > 0)        {
            return orders[0]
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
        
        let fetchRequest = NSFetchRequest(entityName:"Orders")
        
        var error: NSError?
        
        let fetchedResults : [Order] =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [Order]
        
        // Assign the results to the Model
        if fetchedResults.count > 0 {
            orders = fetchedResults
        } else {
     //       println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    func saveProduct(id: Int, item_id: Int, profile_id:Int,
        qty:Int, start_date:String, end_date:String, existing: Order?)
    {
        // Get a reference to your App Delegate
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        // Get a reference to a ManagedObjectContext for interacting with
        // the underlying database
        let managedContext = appDelegate.managedObjectContext!
        
        // Get a entity from the database that represents the table your are
        // wishing to work with
        let entity =  NSEntityDescription.entityForName("Orders",
            inManagedObjectContext:
            managedContext)
        
        if((existing) == nil) {
            // Create an object based on the Entity
            let order = Order(entity: entity!,
                insertIntoManagedObjectContext:managedContext)
            order.identifier = id
            order.qty = qty
            order.start_date = start_date
			order.end_date = end_date
//          order.item_id = item_id
//          order.profile_id = profile_id
            self.orders.append(order)
        } else {
            existing!.identifier = id
            existing!.qty = qty
            existing!.start_date = start_date
			existing!.end_date = end_date
//          existing!.item_id = item_id
//          existing!.profile_id = profile_id
        }
        
        // Check for errors and save
        var error: NSError?
        if !managedContext.save(&error) {
     //       println("Could not save \(error), \(error?.userInfo)")
        }
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