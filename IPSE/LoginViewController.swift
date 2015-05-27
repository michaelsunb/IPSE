//
//  LoginViewController.swift
//  IPSE
//
//  Created by Monster on 25/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var username: UITextField!
	@IBOutlet weak var password: UITextField!
	
	@IBAction func loginButton(sender: AnyObject) {
		// Username empty.
		if(username.text.isEmpty){
			let alert = UIAlertView()
			alert.title = "No Username"
			alert.message = "Please enter a username"
			alert.addButtonWithTitle("OK")
			alert.show()
			// Password empty.
		}else if (password.text.isEmpty) {
			let alert = UIAlertView()
			alert.title = "No Password"
			alert.message = "Please enter a password"
			alert.addButtonWithTitle("OK")
			alert.show()
		}else {
			// Send login credentials to server.
			loginRequest()
		}
		
		
	}
	
	var profileModel = ProfileModel.sharedInstance
	var loginModel = LoginModel.sharedInstance
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.username.delegate = self
		self.password.delegate = self
		
		for login in loginModel.logins {
			println("username: " + login.username + "\t password: " + login.password)
		}
		profileModel.getModel()
		loginModel.getModel()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	func loginRequest(){
		// Check core data first
		if(LoginModel.sharedInstance.checkUserPass(self.username.text, password: self.password.text)) {
			self.getOrdersForUser()
			return
		}
		let urlPath: String = "http://foodorderingsystem.mybluemix.net/login/login.php?username=\(username.text)&password=\(password.text)"
		var url: NSURL = NSURL(string: urlPath)!
		var request1: NSURLRequest = NSURLRequest(URL: url)
		let queue:NSOperationQueue = NSOperationQueue()
		NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
			var err: NSError
			var jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
			
			if let jsonDictionary = jsonResult as? NSDictionary {
				if let userID = jsonDictionary["id"] as? NSInteger {
					Model.sharedInstance.setLoggedInUser(userID)
				}
				if let success = jsonDictionary["Success"] as? NSString {
					
					if success == "true" {
						// User has permission to login.
						dispatch_async(dispatch_get_main_queue(),{
							self.getOrdersForUser()
						})
					}else{
						// User does not have permission to login.
						// Login failed
						let alert = UIAlertView()
						alert.title = "Failed Login"
						alert.message = "The username or password was wrong. Please try again"
						alert.addButtonWithTitle("OK")
						alert.show()
					}
				}
			}
			
		})
	}
	
	// foodorderingsystem.mybluemix.net/orders/getorderid.php?accountid=4
	func loginResult(result:Bool) {
		self.performSegueWithIdentifier("login", sender: nil)
	}
	
	
	func getOrdersForUser(){
		let urlPath: String = "http://foodorderingsystem.mybluemix.net/orders/getorderid.php?accountid=\(Model.sharedInstance.getLoggedInUser())"
		var url: NSURL = NSURL(string: urlPath)!
		var request1: NSURLRequest = NSURLRequest(URL: url)
		let queue:NSOperationQueue = NSOperationQueue()
		NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
			var err: NSError
			var jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
			var tempOrderArray = [Int]()
			if let jsonDictionary = jsonResult as? NSDictionary {
				if let orderIDArray = jsonDictionary["products"] as? NSArray {
					for var i = 0; i < orderIDArray.count; i++ {
						if var orderIDobj = orderIDArray[i] as? NSDictionary {
							println("order     IDOP")
							println(orderIDobj)
							if var orderIDic = orderIDobj["orderID"] as? NSInteger{
								tempOrderArray.append(orderIDic)
							}
						}
						
					}
				}
				// Add orderID to model
				Model.sharedInstance.setOrderID(tempOrderArray)
				
				dispatch_async(dispatch_get_main_queue(),{
					//                    self.getOrdersForUser()
					self.getUserInfo()
				})
			}
		})
	}
	
	func getUserInfo(){
		let urlPath: String = "http://foodorderingsystem.mybluemix.net/products/user.php?accountid=\(Model.sharedInstance.getLoggedInUser())"
		var url: NSURL = NSURL(string: urlPath)!
		var request1: NSURLRequest = NSURLRequest(URL: url)
		let queue:NSOperationQueue = NSOperationQueue()
		NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
			var err: NSError
			var jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
			var tempOrderArray = [Int]()
			if let jsonDictionary = jsonResult as? NSDictionary {
				if let orderIDArray = jsonDictionary["products"] as? NSArray {
					if let credentials = orderIDArray[0] as? NSDictionary {
						var firstn:String
						var lastn:String
						if let firstname = credentials["firstname"] as? String {
							Model.sharedInstance.setFirstName(firstname)
							if let lastname = credentials["lastname"] as? String {
								Model.sharedInstance.setLastName(lastname)
							}
						}
					}
				}
				// Add orderID to model
				Model.sharedInstance.setOrderID(tempOrderArray)
				dispatch_async(dispatch_get_main_queue(),{
					self.loginResult(true)
				})
			}
		})
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		self.view.endEditing(true)
		return false
	}
}
