//
//  TestViewController.swift
//  TeamAudiophile
//
//  Created by Jakub Burkot on 3/22/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UIScrollViewDelegate {

    var bookmarkViewOriginalCenter: CGPoint!
    var deleteViewOriginalCenter: CGPoint!
    
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var instruction1Image: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var finalButton: UIButton!
    @IBOutlet weak var deleteIcon: UIImageView!
    
    @IBOutlet weak var bookmarkView: UIView!
    @IBOutlet weak var bookmarkIcon: UIImageView!
    @IBOutlet weak var bookmarkImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 960, height: 568)
        self.bookmarkIcon.transform = CGAffineTransformMakeScale(0, 0)
        self.deleteIcon.transform = CGAffineTransformMakeScale(0, 0)
        nextButton.alpha = 0
        bookmarkIcon.alpha = 1
        finalButton.alpha = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func goToSecond(sender: AnyObject) {
        scrollView.setContentOffset(CGPoint(x: 320, y: 0), animated: true)
        
    }

    @IBAction func goToThird(sender: AnyObject) {
        scrollView.setContentOffset(CGPoint(x: 640, y: 0), animated: true)
    }
    
    
    
    
    @IBAction func didPanBookmark(sender: AnyObject) {
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if (sender.state == UIGestureRecognizerState.Began) {
            
            bookmarkViewOriginalCenter = bookmarkView.center
            bookmarkImage.alpha = 1
    
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            
            bookmarkView.center.x = bookmarkViewOriginalCenter.x + translation.x
            
            if(translation.x < 60) {
                bookmarkImage.transform = CGAffineTransformMakeTranslation(translation.x - 60, 0)
            }
            
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            
            if(translation.x < 60) {
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.bookmarkView.center = self.bookmarkViewOriginalCenter
                    self.bookmarkImage.alpha = 0
                })
            }
            
            if(translation.x > 60) {
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.bookmarkView.center.x = 115
                    
                    }, completion: { (Bool) -> Void in
                        
                        
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            
                            self.bookmarkView.alpha = 0
                            self.nextButton.alpha = 1
                            self.bookmarkIcon.transform = CGAffineTransformMakeScale(1, 1)
                            self.bookmarkImage.alpha = 0
                            
                            }, completion: { (Bool) -> Void in
                                
                                self.bookmarkIcon.alpha = 1
                        })
                })
                
            }
    
        }
        
    }
    
    @IBAction func didPanDelete(sender: AnyObject) {
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if (sender.state == UIGestureRecognizerState.Began) {
            
            deleteViewOriginalCenter = deleteView.center
    
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            
            deleteView.center.x = deleteViewOriginalCenter.x + translation.x
            
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            
            if(translation.x > -60) {
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.deleteView.center = self.deleteViewOriginalCenter
                    
                })
            }
            
            if(translation.x < -60) {
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.deleteView.center.x = 115
                    
                    }, completion: { (Bool) -> Void in
                        
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.deleteView.alpha = 0
                            self.finalButton.alpha = 1
                            self.deleteIcon.transform = CGAffineTransformMakeScale(1, 1)
                            
                            }, completion: { (Bool) -> Void in
                                self.bookmarkIcon.alpha = 1
                        })
                })
                
            }
    
    }
        
}
    
    
        override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
