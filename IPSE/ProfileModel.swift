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
	
	func getModel() {
		// Get a reference to your App Delegate
		let appDelegate =
		UIApplication.sharedApplication().delegate as AppDelegate
		
		// Get a reference to a ManagedObjectContext for interacting with
		// the underlying database
		let managedContext = appDelegate.managedObjectContext!
		
		
		// Retrieve all the records in the table
		let fetchRequest = NSFetchRequest(entityName:"Profiles")
		var error: NSError?
		let fetchedResults =
		managedContext.executeFetchRequest(fetchRequest,
			error: &error) as [Profile]?
		
		// Assign the results to the Model
		if let results = fetchedResults {
			profiles = results
		} else {
			println("Could not fetch \(error), \(error!.userInfo)")
		}
	}
	
	func saveModel(first_name: String,last_name:String, existing: Profile?) {
		// Get a reference to your App Delegate
		let appDelegate =
		UIApplication.sharedApplication().delegate as AppDelegate
		
		// Get a reference to a ManagedObjectContext for interacting with
		// the underlying database
		let managedContext = appDelegate.managedObjectContext!
		
		// Get a entity from the database that represents the table your are
		// wishing to work with
		let entity =  NSEntityDescription.entityForName("Profiles",
			inManagedObjectContext:
			managedContext)
		
		if((existing) == nil) {
			// Create an object based on the Entity
			let profile = Profile(entity: entity!,
				insertIntoManagedObjectContext:managedContext)
			profile.setValue(self.profiles.count, forKey:"identifer")
			profile.setValue(first_name, forKey:"first_name")
			profile.setValue(last_name, forKey:"last_name")
			
			var error: NSError?
			if !managedContext.save(&error) {
				println("Could not save \(error), \(error?.userInfo)")
			}
			
			self.profiles.append(profile)
		} else {
			existing!.first_name = first_name
			existing!.last_name = last_name
		}
		
		// Check for errors and save
		var error: NSError?
		if !managedContext.save(&error) {
			println("Could not save \(error), \(error?.userInfo)")
		}
	}
}