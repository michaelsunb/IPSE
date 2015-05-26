//
//  MenuCellView.swift
//  IPSE
//
//  Created by User on 24/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import Foundation
import UIKit

class MenuCellView: UITableViewCell {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var mySubtitle: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
	@IBOutlet weak var quantity: UILabel!
	@IBOutlet weak var price: UILabel!
	
	
	@IBAction func quatityStepper(sender: UIStepper) {
		self.quantity.text = Int(sender.value).description
	}
}