//
//  EventCell.swift
//  TeamAudiophile
//
//  Created by Vuhuan Pham on 3/18/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var venueLocation: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var bookmarkImage: UIImageView!
    @IBOutlet weak var trashImage: UIImageView!
    @IBOutlet weak var panView: UIView!
    
    var startingEventCenter: CGPoint!
    var startingViewCenter: CGPoint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        var recognizer = UIPanGestureRecognizer(target: self, action: "didPanEvent:")
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
        
    }
    
    func didPanEvent(recognizer: UIPanGestureRecognizer) {
        
        var translation = recognizer.translationInView(panView)
        var movingView = recognizer.view as UIView!
        
        
        
        if (recognizer.state == .Began) {
            
            startingEventCenter = movingView.center
            
            
        } else if (recognizer.state == UIGestureRecognizerState.Changed) {
            
            if(fabs(translation.x) > fabs(translation.y)) {
                movingView.center = CGPoint(x: startingEventCenter.x + translation.x, y: movingView.center.y)
                
                
            } else {
                UIView.animateWithDuration(0.15, animations: { () -> Void in
                    movingView.center = self.startingEventCenter
                })
                
            }
           
        } else if (recognizer.state == UIGestureRecognizerState.Ended) {
            
            if (translation.x > 160) {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    movingView.center.x = self.startingEventCenter.x + 320
                    
                })
                
                
            } else if (translation.x < -160) {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    movingView.center.x = self.startingEventCenter.x - 320
                })
                
            } else {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    movingView.center = self.startingEventCenter
                })
            }
            
            
            
            
        }
        
    }
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
    }
    
    

}
