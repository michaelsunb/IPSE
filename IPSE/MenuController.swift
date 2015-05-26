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

	@IBAction func submit(sender: UIButton) {
//		println(titleCell)
//		println(qtyCell)
//		println(priceCell)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		println(Model.sharedInstance.getAllProducts())
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.sharedInstance.getCount()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell:MenuCellView = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as MenuCellView

		cell.myLabel.text = Model.sharedInstance.getAllProductsFromArray()[indexPath.row].getName()
		cell.mySubtitle.text = Model.sharedInstance.getAllProductsFromArray()[indexPath.row].getDescription()
		var cost:Int = Model.sharedInstance.getAllProductsFromArray()[indexPath.row].getCost()
		cell.price.text = "$" + String(cost)

        return cell;
	}
	
	var titleCell:String = String()
	var qtyCell:Int = Int()
	var priceCell:Int = Int()

	/**
	 * http://stackoverflow.com/questions/28315133/swift-pass-uitableviewcell-label-to-new-viewcontroller
	 */
	func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
//		println("You selected cell #\(indexPath.row)!")
//		println(tableView.numberOfSections())

		
		// Get Cell Label
		let indexPath = tableView.indexPathForSelectedRow();
		let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as MenuCellView!;
		
		let title = currentCell.myLabel.text
		let quantity = currentCell.quantity.text?.toInt()
		let price = currentCell.price.text?.toInt()
		
		if let titleCell = title { }
		if let qtyCell = quantity { }
		if let priceCell = price { }
	}
}

