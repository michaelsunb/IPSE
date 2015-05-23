//
//  BlueMixDAO.swift
//  SwiftCallURL
//
//  Created by Monster on 21/05/2015.
//  Copyright (c) 2015 Monster. All rights reserved.
//

import Foundation

class BlueMixDAO {
    
    init(){
        
    }
    
    func loginRequest() -> Bool {
        
        
        let urlPath: String = "http:foodorderingsystem.mybluemix.net/login/login.php?username=Tony&password=pass"
        var url: NSURL = NSURL(string: urlPath)!
        var request1: NSURLRequest = NSURLRequest(URL: url)
        let queue:NSOperationQueue = NSOperationQueue()
        var loginRequest:Bool = false
        NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError
            var jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
            println("AsSynchronous\(jsonResult)")
            
            if let jsonDictionary = jsonResult as? NSDictionary {
                if let success = jsonDictionary["Success"] as? NSString {
                    if success == "true" {
                        // User has permission to login.
                        loginRequest = true
                    }else{
                        // User does not have permission to login.
                        loginRequest = false
                    }
                }
                
            }
            
        })
        
        println("calling DAO login")
        return loginRequest
    }
    
    func getAllProducts() -> NSArray? {
        let urlPath: String = "http://foodorderingsystem.mybluemix.net/products/products.php"
        var url: NSURL = NSURL(string: urlPath)!
        var request1: NSURLRequest = NSURLRequest(URL: url)
        let queue:NSOperationQueue = NSOperationQueue()
        var loginRequest:Bool = false
        var productArray:NSArray?
        NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError
            var jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
            
            println("AsSynchronous\(jsonResult)")
            
            if let jsonDictionary = jsonResult as? NSDictionary {
                if let productsArray = jsonDictionary["products"] as? NSArray {
                    productArray = productsArray
                    
                }
            }
            
        })
        
        return productArray?
    }
    
    
}