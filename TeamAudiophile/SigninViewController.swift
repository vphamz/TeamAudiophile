//
//  SigninViewController.swift
//  TeamAudiophile
//
//  Created by Vuhuan Pham on 3/22/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit
import Parse

class SigninViewController: UIViewController {

    @IBOutlet weak var signinView: UIView!
    @IBOutlet weak var signinButtonView: UIView!
    @IBOutlet weak var signinInnerView: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        signinView.layer.cornerRadius = signinView.frame.height/2
        signinButtonView.layer.cornerRadius = signinButtonView.frame.width/2
        signinInnerView.layer.cornerRadius = signinInnerView.frame.width/2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didPressSigninButton(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(usernameTextField.text, password: passwordTextField.text) { (user: PFUser!, error: NSError!) -> Void in
            
            if (user != nil) {
                println("logged in!")
                self.performSegueWithIdentifier("toHamburgerSegue", sender: self)
            } else {
                var alertView = UIAlertView(title: "Oops", message: error.description, delegate: nil, cancelButtonTitle: "OK")
                alertView.show()
            }
        }
    }

    
    @IBAction func didPressCreateAccountButton(sender: AnyObject) {
        
        var user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
            println("User Created")
            
            while (self.usernameTextField.text != PFUser.currentUser().username) {
                
            }
            
            if (success && self.usernameTextField.text == PFUser.currentUser().username ){
                self.performSegueWithIdentifier("toHamburgerSegue", sender: self)
            } else {
                var alertView = UIAlertView(title: "Oops", message: error.description, delegate: nil, cancelButtonTitle: "OK")
                alertView.show()
            }
        }
        
    }
    
    
}
