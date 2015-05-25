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
	
	@IBOutlet var saveImage: UIButton!
	@IBOutlet var txtMovieTitle: UITextField!
	@IBOutlet var txtMovieSubTitle: UITextField!
	var titleOfMovie:String?
	var movieSubTitle:String?
	//    var existingItem: Movie!
	var movieId:String?
	
	// Sets up a networking session
	let session = NSURLSession.sharedSession()
	var tableView:UITableView!
	//    var model = Model.sharedInstance
	
	// Constants for building various url requests to the service
	let BASE_URL:String = "https://api.themoviedb.org/3/"
	let SEARCH_MOVIE:String = "search/movie"
	let MOVIE_DETAILS:String = "movie/"
	let IMAGES_LOCATION = "images"
	let API_KEY :String = "?api_key=5773cfe9c65c621911d8601f1a3d08c2"
	var ID_LENGTH:Int  = 0
	
	var picker:UIImagePickerController?=UIImagePickerController()
	var popover:UIPopoverController?=nil
	
	@IBAction func saveImage(sender: AnyObject) {
		UIImageWriteToSavedPhotosAlbum(image.image, nil, nil, nil);
	}

	@IBAction func changeImage(sender: AnyObject) {
		var alert:UIAlertController=UIAlertController(title:"Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
		
		var cameraAction = UIAlertAction(title:"Camera", style: UIAlertActionStyle.Default) {
			UIAlertAction in
			self.openCamera()
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
//		super.viewDidLoad()
//		picker?.delegate = self
//		tableView = model.getTableView()
//		if(!model.appLoad) {
//			// loads the first movie into the detail view when split screen is being used
//			if let navController = splitViewController?.viewControllers[0] as? UINavigationController {
//				model.appLoad = true
//				txtMovieTitle.text = model.getFirstMovie()?.title
//				txtMovieSubTitle.text = model.getFirstMovie()?.subtitle
//				
//				navController.popViewControllerAnimated(true)
//			}
//		}
//
//		if (existingItem != nil) {
//			txtMovieSubTitle.text = movieSubTitle
//			txtMovieTitle.text = titleOfMovie
//		}
//		getMovie()
	}
	
	@IBAction func save(sender: AnyObject) {
//		Model.sharedInstance.saveMovie(txtMovieTitle.text!, subtitle: txtMovieSubTitle.text!, existing: existingItem)
//		
//		// Updates the master view from the detail view and pops the view if not being shown in split view
//		if let navController = splitViewController?.viewControllers[0] as? UINavigationController
//		{
//			tableView.reloadData()
//			navController.popViewControllerAnimated(true)
//		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}



