//
//  HamburgerViewController.swift
//  TeamAudiophile
//
//  Created by Vuhuan Pham on 3/18/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    var homeView: UIView!
    
    @IBOutlet weak var panView: UIView!
    @IBOutlet weak var appLabel: UILabel!
   
    var menuViewController: MenuViewController!
    var homeViewController: HomeViewController!
    
    var originalCenter: CGPoint!
    var startPanCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        // Create the view controllers
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var menuViewController = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as MenuViewController
        var homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as HomeViewController
        
        // Add the view controllers to the view
        addChildViewController(menuViewController)
        menuViewController.view.frame = menuView.frame
        menuView.addSubview(menuViewController.view)
        menuViewController.didMoveToParentViewController(self)
        
        addChildViewController(homeViewController)
        homeViewController.view.frame = menuView.frame
        contentView.addSubview(homeViewController.view)
        homeViewController.didMoveToParentViewController(self)
        
        
        originalCenter = contentView.center
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPanMenu(sender: UIPanGestureRecognizer) {
        
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            startPanCenter = contentView.center
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            contentView.center.x = startPanCenter.x + translation.x
            panView.center.x = startPanCenter.x + translation.x
            
            //updateRotation(contentView.frame.origin.x)
        } else if sender.state == UIGestureRecognizerState.Ended {
            if velocity.x > 0 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.contentView.center.x = self.originalCenter.x + self.view.frame.size.width - 80
                    self.panView.center.x = self.originalCenter.x + self.view.frame.size.width - 80
                 //   self.updateRotation(self.contentView.frame.origin.x)
                })
            } else {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.contentView.center.x = self.originalCenter.x
                    self.panView.center.x = self.originalCenter.x
                    //self.homeView.layer.transform = CATransform3DIdentity
                })
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
