//
//  ProfileModel.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 26/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import CoreData
import Foundation
import UIKit

/**
 * Core Data help
 * https://www.youtube.com/watch?v=3IDfgATVqHw
 */
class ProfileModel {
	/**
	* Reference to thread safe singleton at bottom on page
	* http://code.martinrue.com/posts/the-singleton-pattern-in-swift
	*/
	class var sharedInstance: ProfileModel {
		struct Static {
			static var instance: ProfileModel?
			static var token: dispatch_once_t = 0
		}
		dispatch_once(&Static.token) {
			Static.instance = ProfileModel()
		}
		return Static.instance!
	}
	
	var profiles:[Profile] = [Profile]()
	var appLoad: Bool = false
	var tableView:UITableView!
	
	func setTableView(tableView: UITableView) {
		self.tableView = tableView
	}
	
	func getTableView() -> UITableView {
		return tableView
	}
	
	func getFirstModel() -> Profile? {
		if (profiles.count > 0) {
			return profiles[0]
		}
		return nil
    }
    
    func getLastModel() -> Profile? {
        if (profiles.count > 0) {
            return profiles.last
        }
        return nil
    }
	
	func getModel() {
		if(profiles.count <= 0) {
			return
		}
		// Get a reference to your App Delegate
		let appDelegate =
		UIApplication.sharedApplication().delegate as AppDelegate
		
		// Get a reference to a ManagedObjectContext for interacting with
		// the underlying database
		let managedContext = appDelegate.managedObjectContext!
		
		
		// Retrieve all the records in the table
		let fetchRequest = NSFetchRequest(entityName:"Profiles")
        fetchRequest.returnsObjectsAsFaults = false
        
		var error: NSError?
        let fetchedResults:NSArray =
		managedContext.executeFetchRequest(fetchRequest,
			error: &error)!
		
		// Assign the results to the Model
		if fetchedResults.count > 0 {
            var profilez:[Profile]
            for res in fetchedResults {
//                let id: Int? = res.valueForKey("identifier") as? Int
//                let first_name: String? = res.valueForKey("first_name") as? String
//                let last_name: String? = res.valueForKey("last_name") as? String
                println(res)
            }
		} else {
			println("Could not fetch \(error), \(error!.userInfo)")
		}
	}
	
	func saveModel(first_name: String,last_name:String) {
		// Get a reference to your App Delegate
		let appDelegate =
		UIApplication.sharedApplication().delegate as AppDelegate
		
		// Get a reference to a ManagedObjectContext for interacting with
		// the underlying database
		let managedContext = appDelegate.managedObjectContext!
		
		// Get a entity from the database that represents the table your are
		// wishing to work with
        let entity: NSManagedObject =  NSEntityDescription.insertNewObjectForEntityForName("Profiles", inManagedObjectContext: managedContext) as NSManagedObject
		
		entity.setValue(String(self.profiles.count), forKey:"identifier")
		entity.setValue(first_name, forKey:"first_name")
        entity.setValue(last_name, forKey:"last_name")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
		
        self.profiles.append(Profile(identifier: String(self.profiles.count),first_name:first_name,last_name:last_name))
    }
    
    func updateModel(id:String,first_name: String,last_name:String) {
        // Get a reference to your App Delegate
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        // Get a reference to a ManagedObjectContext for interacting with
        // the underlying database
        let managedContext = appDelegate.managedObjectContext!
        
        // Get a entity from the database that represents the table your are
        // wishing to work with
        let entity: NSManagedObject =  NSEntityDescription.insertNewObjectForEntityForName("Profiles", inManagedObjectContext: managedContext) as NSManagedObject
        
        entity.setValue(String(self.profiles.count), forKey:"identifier")
        entity.setValue(first_name, forKey:"first_name")
        entity.setValue(last_name, forKey:"last_name")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        self.profiles.append(Profile(identifier: String(self.profiles.count),first_name:first_name,last_name:last_name))
    }
}