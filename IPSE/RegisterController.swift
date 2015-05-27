//
//  RegisterController.swift
//  IPSE
//
//  Created by Michaelsun Baluyos on 26/05/2015.
//  Copyright (c) 2015 rmit. All rights reserved.
//

import UIKit

class RegisterController: UIViewController, UITextFieldDelegate {
	@IBOutlet weak var nameText: UITextField!
	@IBOutlet weak var lastText: UITextField!
	@IBOutlet weak var usernameText: UITextField!
	@IBOutlet weak var passwordText: UITextField!
	@IBOutlet weak var reEnterText: UITextField!
	
	@IBAction func signUp(sender: UIButton) {
		if(nameText.text.isEmpty || lastText.text.isEmpty || usernameText.text.isEmpty || passwordText.text.isEmpty || reEnterText.text.isEmpty){
			let alert = UIAlertView()
			alert.title = "Incomplete"
			alert.message = "Please enter required fields"
			alert.addButtonWithTitle("OK")
			alert.show()
			// Password empty.
			return
		}
		
		if(passwordText.text != reEnterText.text) {
			let alert = UIAlertView()
			alert.title = "Incomplete"
			alert.message = "Please re-enter same password"
			alert.addButtonWithTitle("OK")
			alert.show()
			// Password not equals.
			return
		}
		
		profileModel.saveModel(nameText.text, last_name: lastText.text)
		loginModel.saveModel(usernameText.text, password:passwordText.text,toProfile:profileModel.getLastModel()!)
		registerResult(true)
	}
	
	var profileModel = ProfileModel.sharedInstance
	var loginModel = LoginModel.sharedInstance
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//Do any additional setup after loading the view, typically from a nib.
		profileModel.getModel()
		loginModel.getModel()
        
		self.nameText.delegate = self;
		self.lastText.delegate = self;
		self.usernameText.delegate = self;
		self.passwordText.delegate = self;
		self.reEnterText.delegate = self;
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	private func registerResult(result:Bool) {
		self.performSegueWithIdentifier("register", sender: nil)
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		self.view.endEditing(true)
		return false
	}
}