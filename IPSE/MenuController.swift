//
//  ViewController.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 12/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UITableViewDelegate {
    let products:[ProductTest] = ProductModel.sharedInstance.getProductTest()
    var images:[String:UIImage]?

    override func viewDidLoad() {
        super.viewDidLoad()
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
        return products.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell:MenuCellView = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as MenuCellView

//        let product = products[indexPath.row]

        
        cell.myLabel.text = "Hwllo"
        cell.mySubtitle.text = "again"
//        cell.myLabel.text = product.name
//        cell.mySubtitle.text = product.desc
        
//        let testAPI = ProductTestAPI()
//        if let image:UIImage = testAPI.getMovie(product.product_image) {
//            cell.myImageView.image = image
//        }
//        println("The loaded image: \(cell.myImageView.image)")

        return cell;
    }
}

