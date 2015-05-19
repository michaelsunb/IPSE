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
class Model {

    var tables : AllTables = AllTables()
    
    init() {
        getTable("Products")
        getTable("Favourites")
    }
    
    func getTable(tableName:String) -> [iTable] {
        
        var table : [iTable] = [iTable]()

        switch(tableName) {
        case Product.getTableName:
            if(tables.products.count <= 0) {
                tables.products = [Product]()
                
                for res : Product in loadTable(tableName) as [Product] {
                    tables.products.append(res)
                }
            }
            table = tables.products
            break
        case Favourite.getTableName:
            if(tables.products.count <= 0) {
                tables.favourites = [Favourite]()
                
                for res : Favourite in loadTable(tableName) as [Favourite] {
                    tables.favourites.append(res)
                }
            }
            table = tables.favourites
            break
        default:
            break
        }
        
        return table
    }
    
//    func save(tab:iTable) {
//        
//        let appDelegate:AppDelegate =
//        UIApplication.sharedApplication().delegate as AppDelegate
//        
//        let managedContext:NSManagedObjectContext = appDelegate.managedObjectContext!
//        var newEntry = NSEntityDescription.insertNewObjectForEntityForName(tab.getTableName, inManagedObjectContext: managedContext) as iTable
//        
//        newEntry.newEntry(tab)
//        
//        var table:[iTable] = [newEntry]
//        if var table = tables[tab.getTableName] {
//            table.append(newEntry)
//        }
//
//        self.tables[tab.getTableName] = table
//    }
    
    private func loadTable(tableName:String) -> [iTable] {
        
        let appDelegate:AppDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:tableName)

        var error: NSError?

        let fetchedResults : [iTable] =
            managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [iTable]

        // Assign the results to the Model
        if fetchedResults.count > 0 {
            return fetchedResults
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        return fetchedResults
    }

    /**
     * Reference to thread safe singleton at bottom on page
     * http://code.martinrue.com/posts/the-singleton-pattern-in-swift
     */
    class var sharedInstance: Model {
        struct Static {
            static var instance: Model?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Model()
        }
        
        return Static.instance!
    }
}