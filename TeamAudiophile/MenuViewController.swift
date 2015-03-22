//
//  MenuViewController.swift
//  TeamAudiophile
//
//  Created by Vuhuan Pham on 3/18/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        profileView.backgroundColor = UIColor.yellowColor()
        profileView.layer.cornerRadius = profileView.frame.width/2
        innerView.layer.cornerRadius = innerView.frame.width/2
        //profileImage.center = profileView.center
        profileImage.image = UIImage(named: "generic-profile")
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressUserButton(sender: AnyObject) {
    }

    @IBAction func didPressAccountButton(sender: AnyObject) {
    }
    
    @IBAction func didPressSignoutButton(sender: AnyObject) {
    }

}
