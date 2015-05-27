//
//  ViewController.swift
//  TakeAway
//
//  Created by Rodney Cocker on 19/04/2015.
//  Copyright (c) 2015 RMIT. All rights reserved.
//

import UIKit

class ProfileController: UIViewController, UIAlertViewDelegate, UIPopoverControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
	@IBOutlet var image: UIImageView!
	
	@IBOutlet weak var surname: UILabel!
	@IBOutlet weak var name: UILabel!
	@IBOutlet var saveImage: UIButton!
	var existingItem: Profile!
	
	// Sets up a networking session
	let session = NSURLSession.sharedSession()
	var tableView:UITableView!
	var model = ProfileModel.sharedInstance
	
	var picker:UIImagePickerController?=UIImagePickerController()
	var popover:UIPopoverController?=nil
	
	
	@IBAction func changeImage(sender: AnyObject) {
		var alert:UIAlertController=UIAlertController(title:"Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
		
		var cameraAction = UIAlertAction(title:"Camera", style: UIAlertActionStyle.Default) {
			UIAlertAction in self.openCamera()
		}
		
		var gallaryAction = UIAlertAction(title:"Gallary", style: UIAlertActionStyle.Default) {
			UIAlertAction in self.openGallary()
		}
		
		var cancelAction = UIAlertAction(title:"Cancel", style: UIAlertActionStyle.Cancel) {
			UIAlertAction in
		}
		
		// Add the actions
		alert.addAction(cameraAction)
		alert.addAction(gallaryAction)
		alert.addAction(cancelAction)
		
		// Present the actionsheet
		if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
			self.presentViewController(alert, animated: true, completion: nil)
		} else {
			popover=UIPopoverController(contentViewController: alert)
			popover!.presentPopoverFromRect(saveImage.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
		}
	}
	
	func openCamera() {
		if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
			// Check if the device supports the use of a camera
			picker!.sourceType = UIImagePickerControllerSourceType.Camera
			self.presentViewController(picker!, animated: true, completion: nil)
		} else {
			openGallary()
		}
	}
	
	func openGallary() {
		picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
		if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
			self.presentViewController(picker!, animated: true, completion: nil)
		} else {
			popover=UIPopoverController(contentViewController: picker!)
			popover!.presentPopoverFromRect(saveImage.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
		}
	}
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
		if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
			self.image.contentMode = .ScaleAspectFit
			self.image.image = pickedImage
		}
		
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
		picker.dismissViewControllerAnimated(true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		picker?.delegate = self
		tableView = model.getTableView()
		if(!model.appLoad) {
			if let navController = splitViewController?.viewControllers[0] as? UINavigationController {
				model.appLoad = true
				navController.popViewControllerAnimated(true)
			}
		}
		
		name.text = Model.sharedInstance.getFirstName()
		surname.text = Model.sharedInstance.getLastName()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}



