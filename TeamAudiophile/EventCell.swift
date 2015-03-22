//
//  EventCell.swift
//  TeamAudiophile
//
//  Created by Vuhuan Pham on 3/18/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate {
    // indicates that the given item has been deleted
    func eventItemBookmarked(EventItem: EventItem)
    func eventItemDeleted(EventItem: EventItem)
}

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
    
    var deleteOnDragRelease = false
    var bookmark = false
    var delete = false
    
    // The object that acts as delegate for this cell.
    var delegate: TableViewCellDelegate!
    // The item that this cell renders.
    var eventItem: EventItem!
    
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
            
            deleteOnDragRelease = fabs(translation.x) > 160
           
        } else if (recognizer.state == UIGestureRecognizerState.Ended) {
            
            if (translation.x > 160) {
                UIView.animateWithDuration(0.15, animations: { () -> Void in
                    movingView.center.x = self.startingEventCenter.x + 320
                })
                bookmark = true
                
                
            } else if (translation.x < -160) {
                UIView.animateWithDuration(0.15, animations: { () -> Void in
                    movingView.center.x = self.startingEventCenter.x - 320
                })
                delete = true
                
            } else {
                UIView.animateWithDuration(0.15, animations: { () -> Void in
                    movingView.center = self.startingEventCenter
                })
            }
            
            
            
            if deleteOnDragRelease && bookmark {
                if delegate != nil && eventItem != nil {
                    // notify the delegate that this item should be deleted
                    delegate!.eventItemBookmarked(eventItem!)
                }
            }
            
            if deleteOnDragRelease && delete {
                if delegate != nil && eventItem != nil {
                    // notify the delegate that this item should be deleted
                    delegate!.eventItemDeleted(eventItem!)
                }
            }
            
            bookmark = false
            delete = false
            
            
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
