//
//  ViewController.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 12/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var images:[String:UIImage]?

    @IBAction func submit(sender: UIButton) {
        for menuCell in menuCells {
            println("id: \(menuCell.id)")
            println("title: \( menuCell.title)")
            println("qty: \(menuCell.qty)")
            println("price: \(menuCell.price)")

			var dateForatter = NSDateFormatter()
			dateForatter.dateFormat = "dd-MM-yyyy"
			var dateString = dateForatter.stringFromDate(NSDate())
			orderModel.saveModel(menuCell.qty, start_date: dateString, end_date: String())
			
			self.submitOrder(true)
        }
	}
	
	private func submitOrder(result:Bool) {
		self.performSegueWithIdentifier("submitOrder", sender: nil)
	}
	override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
		if(identifier == "submitOrder"){
			
			return true
		}
		return false
	}
	

    var orderModel = OrderModel.sharedInstance
    
	override func viewDidLoad() {
		super.viewDidLoad()
		println(Model.sharedInstance.getAllProducts())
        orderModel.getModel()
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

	func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {

        if(contains(indexPath.row)) {
            var i = 0
            for menuCell in menuCells {
                if(menuCell.id == indexPath.row) {
                    menuCells.removeAtIndex(i)
                }
                i++
            }
        }
        println(menuCells.count)
	}
	
	private var menuCells:[MenuCell] = [MenuCell]()
	
	func contains(index:Int) -> Bool {
		for menuCell in menuCells {
			if(menuCell.id == index) {
				return true
			}
		}
		return false
	}
	
	/**
	 * http://stackoverflow.com/questions/28315133/swift-pass-uitableviewcell-label-to-new-viewcontroller
	 */
	func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
		// Get Cell Label
		let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as MenuCellView!;
		
		let title = currentCell.myLabel.text
		let quantity = currentCell.quantity.text?.toInt()
		let price = currentCell.price.text?.toInt()
		
        var index:Int
        if let indexP = indexPath {
            index = indexP.row
        } else {
            return
        }

		var tit:String
		var qty:Int
		var pri:Int

		if let titleCell = title {
			tit = titleCell
		} else {
			return
        }

		if let qtyCell = quantity {
			qty = qtyCell
		} else {
			return
        }
//        
//        if let priceCell = price {
//            pri = qtyCell
//        } else {
//            return
//        }

        menuCells.append(MenuCell(id:index,title:tit,qty:qty,price:0))
        println(menuCells.count)
	}
}
