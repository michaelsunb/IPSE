//
//  MasterViewController.swift
//  etetwtwhr
//
//  Created by Michaelsun Baluyos on 10/04/2015.
//  Copyright (c) 2015 Michaelsun Baluyos. All rights reserved.
//

import UIKit

class OrdersController: UITableViewController {

	var objects = NSMutableArray()
	var model = ProfileModel.sharedInstance


    override func awakeFromNib() {
		super.awakeFromNib()
		model.setTableView(self.tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        println(Model.sharedInstance.getOrderID())
        getAllProducts()
      //  println(getAllProducts())
        
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationItem.leftBarButtonItem = self.editButtonItem()

   //     println("Order Controller")
    //    println(Model.sharedInstance.loginRequest())
        //let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        //self.navigationItem.rightBarButtonItem = addButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insertObject(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                
                var images:[String:UIImage] = [String:UIImage]()
                for product in ProductModel.sharedInstance.getProductTest() {
                    if let image = ProductTestAPI.sharedInstance.getMovie(product.product_image) {
                        images[product.product_image] = image
                    }
                }
                
                
           // (segue.destinationViewController as MenuController).images = images
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.sharedInstance.getOrderID().count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:OrdersTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as OrdersTableViewCell
        
        cell.OrderIDLabel.text = String(Model.sharedInstance.getOrderID()[indexPath.row] + 1000000)
        
//        cell.textLabel!.text = String(Model.sharedInstance.getOrderID()[indexPath.row])
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
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
            
            //            println("AsSynchronous\(jsonResult)")
            
            if let jsonDictionary = jsonResult as? NSDictionary {
                if let productsArray = jsonDictionary["products"] as? NSArray {
                    dispatch_async(dispatch_get_main_queue(), {
                        productArray = productsArray
                        println(productsArray[0]["cost"])
                        if let cost = productsArray[0]["cost"] as? NSInteger{
                     //   println(cost)
                        }
                        for var i = 0 ; i < 3 ; i++ {
                            var productID :Int = 0
                            var productCost:Int = 0
                            var productName:String = "null"
                            var productDescription:String = "null"
                            
                            if var id  = productsArray[i]["id"] as? NSInteger{
                                productID = id
                            }
                            if var cost = productsArray[i]["cost"] as? NSInteger {
                                productCost = cost
                            }
                            if var name = productsArray[i]["name"] as? NSString {
                                productName = name
                            }
                            if var description = productsArray[i]["description"] as? NSString{
                                productDescription = description
                            }
                            var product:Products = Products(productID: productID, name: productName, description: productDescription,cost: productCost)
                            Model.sharedInstance.addProductToArray(product)
                            println(product.getName())
                        }
                        var prod = Model.sharedInstance.getAllProductsFromArray()
                        
                        Model.sharedInstance.iterateProducts()
                        
                        self.getResultsProducts(productsArray)
                    })
                   
                    
                    
                }
            }
            
        })
       // println(productArray)
        return productArray?
    }
    
    func getResultsProducts(productsArray:NSArray) {
        println("THIS IS THE GETRESULTSPRODUCTS")
        println(Model.sharedInstance.getCount())
     //   println(productsArray)
    }


}

