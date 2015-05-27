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

class ProductModel {
	
	var products:[Product] = [Product]()
	
	func getModel() {
		// Get a reference to your App Delegate
		let appDelegate =
		UIApplication.sharedApplication().delegate as AppDelegate
		
		// Get a reference to a ManagedObjectContext for interacting with
		// the underlying database
		let managedContext = appDelegate.managedObjectContext!
		
		
		// Retrieve all the records in the table
		let fetchRequest = NSFetchRequest(entityName:"Products")
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
	
	func saveModel(name:String,cost:Int,desc:String) {
		if (products.count <= 0) {
			return
		}
		
		// Get a reference to your App Delegate
		let appDelegate =
		UIApplication.sharedApplication().delegate as AppDelegate
		
		// Get a reference to a ManagedObjectContext for interacting with
		// the underlying database
		let managedContext = appDelegate.managedObjectContext!
		
		// Get a entity from the database that represents the table your are
		// wishing to work with
		let entity: NSManagedObject =  NSEntityDescription.insertNewObjectForEntityForName("Products", inManagedObjectContext: managedContext) as NSManagedObject
		
		let id = String(self.products.count)
		entity.setValue(id, forKey:"identifier")
		entity.setValue(name, forKey:"name")
		entity.setValue(cost, forKey:"cost")
		entity.setValue(desc, forKey:"desc")
		
		var error: NSError?
		if !managedContext.save(&error) {
			println("Could not save \(error), \(error?.userInfo)")
		}
		
		self.products.append(Product(identifier:id,name:name,cost:cost,desc:desc))
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