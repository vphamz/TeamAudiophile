//
//  HomeViewController.swift
//  TeamAudiophile
//
//  Created by Vuhuan Pham on 3/18/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {

    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var eventCell: EventCell!
    
    @IBOutlet weak var toasterView: UIView!
    @IBOutlet weak var toasterIcon: UIImageView!
    @IBOutlet weak var toasterLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var startingEventCenter: CGPoint!
    var startingViewCenter: CGPoint!
    
    var numRecordsInArray = 20
    
    var eventImages: [UIImage] = []
    var eventItems = [EventItem]()
    
    var bookmark = false
    var delete = false

    var parseEventItems: [PFObject]! = []
    var parseEvent = PFObject(className: "EventTest")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        eventTableView.rowHeight = 150
        eventTableView.backgroundColor = UIColor.blackColor()
        eventTableView.allowsSelection = false
        eventTableView.separatorColor = UIColor.yellowColor()
        
        toasterView.layer.cornerRadius = toasterView.frame.width/2
        toasterView.hidden = true
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var apiViewController = storyboard.instantiateViewControllerWithIdentifier("APIViewController") as APIViewController
        
        
        
        indicator.startAnimating()
        
        UIView.animateWithDuration(3.0, animations: { () -> Void in
            //
            
            apiViewController.viewDidLoad()
            self.eventTableView.backgroundColor = UIColor.blackColor()
            
        }, completion: { (Bool) -> Void in
            //
            self.indicator.hidesWhenStopped = true
            self.indicator.stopAnimating()
            self.getParseEvents()
        })
        
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as EventCell
        
        let item = eventItems[indexPath.row]
        
        //cell.eventName.text = String(indexPath.row)
        cell.eventName.text = item.desc
        cell.artistName.text = item.artist
        cell.venueName.text = item.venueName
        cell.venueLocation.text = item.city
        cell.eventDate.text = item.date
        cell.eventImage.image = item.image
        
        cell.delegate = self
        cell.eventItem = item
        
        return cell
        
    }
    

    func eventItemBookmarked(eventItem: EventItem) {
        let index = (eventItems as NSArray).indexOfObject(eventItem)
        if index == NSNotFound { return }
        
        eventTableView.backgroundColor = UIColor.greenColor()
        
        toasterView.hidden = false
        toasterView.backgroundColor = UIColor.greenColor()
        toasterIcon.image = UIImage(named: "archive_icon")
        toasterLabel.text = "Saved!"
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            // could removeAtIndex in the loop but keep it here for when indexOfObject works
            self.eventItems.removeAtIndex(index)
            
            // use the UITableView to animate the removal of this row
            self.eventTableView.beginUpdates()
            let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
            self.eventTableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
            self.eventTableView.endUpdates()
            
            
            }, completion: { (Bool) -> Void in
                
                self.eventTableView.backgroundColor = UIColor.blackColor()
                
            }
        )
        
        
        
        showHideToaster()
        
        
        
        
    }
    
    func eventItemDeleted(eventItem: EventItem) {
        let index = (eventItems as NSArray).indexOfObject(eventItem)
        if index == NSNotFound { return }
        
        eventTableView.backgroundColor = UIColor.redColor()
        
        toasterView.hidden = false
        toasterView.backgroundColor = UIColor.redColor()
        toasterIcon.image = UIImage(named: "delete_icon")
        toasterLabel.text = "Declined"
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            // could removeAtIndex in the loop but keep it here for when indexOfObject works
            self.eventItems.removeAtIndex(index)
            
            // use the UITableView to animate the removal of this row
            self.eventTableView.beginUpdates()
            let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
            self.eventTableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
            self.eventTableView.endUpdates()
            
            } , completion: { (Bool) -> Void in
                
                self.eventTableView.backgroundColor = UIColor.blackColor()
                
            }
        )
        
        
        
        showHideToaster()
        
        
    }
    

    func showHideToaster(){
        
        toasterView.hidden = false
        toasterView.alpha = 0.8
        
        UIView.animateWithDuration(1.5, animations: { () -> Void in
        
            self.toasterView.alpha = 0.0
            
        })
        
        
        
        
    }

    func getParseEvents(){
        var query = PFQuery(className: "EventTest")
        query.whereKey("userUID", equalTo: PFUser.currentUser().username)
        query.orderByDescending("updatedAt")
        
        
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            
            self.parseEventItems = objects as [PFObject]
            
            
            
            
            
            for var n = 0; n < self.numRecordsInArray; n++ {
                
                var tempImage: UIImage!
                
                if (n % 7 == 0) { tempImage = UIImage(named: "audiophile7")! }
                else if (n % 6 == 0) { tempImage = UIImage(named: "audiophile6")! }
                else if (n % 5 == 0) { tempImage = UIImage(named: "audiophile5")! }
                else if (n % 4 == 0) { tempImage = UIImage(named: "audiophile4")! }
                else if (n % 3 == 0) { tempImage = UIImage(named: "audiophile3")! }
                else if (n % 2 == 0) { tempImage = UIImage(named: "audiophile2")! }
                else if (n % 1 == 0) { tempImage = UIImage(named: "audiophile1")! }
                
                let parseEventArtists = self.parseEventItems[0]["eventArtists"].objectAtIndex(n) as String
                let parseEventCities = self.parseEventItems[0]["eventCities"].objectAtIndex(n) as String
                let parseEventDates = self.parseEventItems[0]["eventDates"].objectAtIndex(n) as String
                let parseEventDescriptions = self.parseEventItems[0]["eventDescriptions"].objectAtIndex(n) as String
                let parseEventIDs = self.parseEventItems[0]["eventIDs"].objectAtIndex(n) as Int
                let parseUserUIDs = self.parseEventItems[0]["userUID"] as String
                let parseEventVenues = self.parseEventItems[0]["eventVenues"].objectAtIndex(n) as String
                
                
                
                self.eventItems.append(EventItem(text: "text", desc: parseEventDescriptions, id: parseEventIDs, useruid: parseUserUIDs, venueName: parseEventVenues, date: parseEventDates, location: parseEventCities, city: parseEventCities, artist: parseEventArtists, image: tempImage ))
            }
            
            
            self.eventTableView.reloadData()
            
        
        }
        
    }
    

}
