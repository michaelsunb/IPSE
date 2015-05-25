//
//  ViewController.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 12/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let products:[ProductTest] = ProductModel.sharedInstance.getProductTest()
    var images:[String:UIImage]?

    override func viewDidLoad() {
        super.viewDidLoad()
//        getAllProducts()
        println(Model.sharedInstance.getAllProducts())
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(Model.sharedInstance.getCount())
        println("model Count")
        println(Model.sharedInstance.getCount())
        return Model.sharedInstance.getCount()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell:MenuCellView = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as MenuCellView

//        let product = products[indexPath.row]

        cell.label1.text = Model.sharedInstance.getAllProductsFromArray()[indexPath.row].getName()
//        println(Model.sharedInstance.getAllProductsFromArray()[0].getName())
        //        cell.myLabel.text = "Hwllo"
//        cell.mySubtitle.text = "again"
//        cell.myLabel.text = product.name
//        cell.mySubtitle.text = product.desc
        
//        let testAPI = ProductTestAPI()
//        if let image:UIImage = testAPI.getMovie(product.product_image) {
//            cell.myImageView.image = image
//        }
//        println("The loaded image: \(cell.myImageView.image)")

        return cell;
    }
    
//    func getAllProducts() -> NSArray? {
//        let urlPath: String = "http://foodorderingsystem.mybluemix.net/products/products.php"
//        var url: NSURL = NSURL(string: urlPath)!
//        var request1: NSURLRequest = NSURLRequest(URL: url)
//        let queue:NSOperationQueue = NSOperationQueue()
//        var loginRequest:Bool = false
//        var productArray:NSArray?
//        NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//            var err: NSError
//            var jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
//            
//            //            println("AsSynchronous\(jsonResult)")
//            
//            if let jsonDictionary = jsonResult as? NSDictionary {
//                if let productsArray = jsonDictionary["products"] as? NSArray {
//                    dispatch_async(dispatch_get_main_queue(), {
//                        productArray = productsArray
//                        println(productsArray[0]["cost"])
//                        if let cost = productsArray[0]["cost"] as? NSInteger{
//                            //   println(cost)
//                        }
//                        for var i = 0 ; i < 3 ; i++ {
//                            var productID :Int = 0
//                            var productCost:Int = 0
//                            var productName:String = "null"
//                            var productDescription:String = "null"
//                            
//                            if var id  = productsArray[i]["id"] as? NSInteger{
//                                productID = id
//                            }
//                            if var cost = productsArray[i]["cost"] as? NSInteger {
//                                productCost = cost
//                            }
//                            if var name = productsArray[i]["name"] as? NSString {
//                                productName = name
//                            }
//                            if var description = productsArray[i]["description"] as? NSString{
//                                productDescription = description
//                            }
//                            var product:Products = Products(productID: productID, name: productName, description: productDescription,cost: productCost)
//                            Model.sharedInstance.addProductToArray(product)
//                            println(product.getName())
//                        }
//                        var prod = Model.sharedInstance.getAllProductsFromArray()
//                        
//                        Model.sharedInstance.iterateProducts()
//                        
//                        self.getResultsProducts(productsArray)
//                    })
//                    
//                    
//                    
//                }
//            }
//            
//        })
//        // println(productArray)
//        return productArray?
//    }
//    
//    func getResultsProducts(productsArray:NSArray) {
//        println("THIS IS THE GETRESULTSPRODUCTS")
//        //   println(productsArray)
//    }
    
}

