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
	@IBOutlet weak var QuantityStepper: UIStepper!
	@IBOutlet weak var Quantity: UILabel!
	@IBOutlet weak var price: UILabel!
}