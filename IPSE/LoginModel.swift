//
//  LoginModel.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 26/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import CoreData
import Foundation
import UIKit

class LoginModel {
	/**
	* Reference to thread safe singleton at bottom on page
	* http://code.martinrue.com/posts/the-singleton-pattern-in-swift
	*/
	class var sharedInstance: LoginModel {
		struct Static {
			static var instance: LoginModel?
			static var token: dispatch_once_t = 0
		}
		dispatch_once(&Static.token) {
			Static.instance = LoginModel()
		}
		return Static.instance!
	}
	
	var logins:[Login] = [Login]()
	
	func getFirstModel() -> Login? {
		if (logins.count > 0) {
			return logins[0]
		}
		return nil
    }
	
	func checkUserPass(username:String,password:String)->Bool {
		for login in logins {
			if(login.username == username &&
				login.password == password) {
					return true
			}
		}
		return false
	}
	
	func getModel() {
		// Get a reference to your App Delegate
		let appDelegate =
		UIApplication.sharedApplication().delegate as AppDelegate
		
		// Get a reference to a ManagedObjectContext for interacting with
		// the underlying database
		let managedContext = appDelegate.managedObjectContext!
		
		
		// Retrieve all the records in the table
		let fetchRequest = NSFetchRequest(entityName:"Logins")
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
            //println("Could not fetch \(error), \(error!.userInfo)")
        }
	}
	
	func saveModel(username:String,password:String,toProfile:Profile) {
		// Get a reference to your App Delegate
		let appDelegate =
		UIApplication.sharedApplication().delegate as AppDelegate
		
		// Get a reference to a ManagedObjectContext for interacting with
		// the underlying database
		let managedContext = appDelegate.managedObjectContext!
		
		// Get a entity from the database that represents the table your are
        // wishing to work with
        let entity: NSManagedObject =  NSEntityDescription.insertNewObjectForEntityForName("Logins", inManagedObjectContext: managedContext) as NSManagedObject
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        self.logins.append(Login(identifier:String(self.logins.count),username:username,password:password,toProfile:toProfile))
	}
}