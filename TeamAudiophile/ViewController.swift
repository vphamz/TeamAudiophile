//
//  ViewController.swift
//  TeamAudiophile
//
//  Created by Vuhuan Pham on 3/16/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UIImageView!
    @IBOutlet weak var bookmarkView: UIView!
    @IBOutlet weak var listContainer: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    var bookmarkViewOriginalCenter: CGPoint!

    @IBOutlet weak var bookmarkImage: UIImageView!
    
    @IBOutlet weak var bookmarkIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.alpha = 0
        bookmarkImage.alpha = 0

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func didPanMessage(sender: AnyObject) {
        
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if (sender.state == UIGestureRecognizerState.Began) {
            
            bookmarkViewOriginalCenter = bookmarkView.center
            
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            
            bookmarkView.center.x = bookmarkViewOriginalCenter.x + translation.x
            
            if(translation.x < 60) {
                bookmarkIcon.transform = CGAffineTransformMakeTranslation(translation.x - 20, 0)
                }
                
            else if (translation.x > 60) {
                bookmarkIcon.transform = CGAffineTransformMakeTranslation(translation.x - 20, 0)
            }
            else if (translation.x > 112) {
                bookmarkIcon.transform = CGAffineTransformMakeTranslation(112, 0)
            }
            
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            if(translation.x < 60) {
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.bookmarkView.center = self.bookmarkViewOriginalCenter
                    self.bookmarkIcon.alpha = 0
                })
            }
            
            if(translation.x > 60) {
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.bookmarkView.center.x = 115
                    
                }, completion: { (Bool) -> Void in
                    
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.bookmarkView.alpha = 0
                        self.textLabel.center.y = 65
                        self.nextButton.alpha = 1
                        self.bookmarkIcon.alpha = 0
                        
                        }, completion: { (Bool) -> Void in
                            self.bookmarkImage.alpha = 1
                    })
                })
            }
        }
    }
        override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}