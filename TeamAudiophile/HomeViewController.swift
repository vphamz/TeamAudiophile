//
//  HomeViewController.swift
//  TeamAudiophile
//
//  Created by Vuhuan Pham on 3/18/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {

    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var eventCell: EventCell!
    
    @IBOutlet weak var toasterView: UIView!
    @IBOutlet weak var toasterIcon: UIImageView!
    @IBOutlet weak var toasterLabel: UILabel!
    
    var startingEventCenter: CGPoint!
    var startingViewCenter: CGPoint!
    
    var movies = [String]()
    
    var api_key: String!
    var events: NSDictionary!
    var eventDescriptions: [String] = []
    var eventIDs: [Int] = []
    var eventDates: [String] = []
    var eventVenues: [String] = []
    var eventCities: [String] = []
    var eventArtists: [String] = []
    var status: String!
    var numRecordsInArray = 100
    var eventImages: [UIImage] = []
    
    var eventItems = [EventItem]()
    
    var bookmark = false
    var delete = false

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        eventTableView.rowHeight = 150
        eventTableView.backgroundColor = UIColor.blackColor()
        
        
        movies = ["the last samarai", "taken", "bond 007", "house of cards", "dexter"]
        
        eventTableView.allowsSelection = false
        eventTableView.separatorColor = UIColor.yellowColor()
        
        
        /**
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var apiViewController = storyboard.instantiateViewControllerWithIdentifier("APIViewController") as APIViewController
        
        apiViewController.viewDidLoad()
        println(apiViewController.eventCities)
        **/
        
        
        
        
        eventTableView.reloadData()
        
        
        
        
        
        
        for var n = 0; n < self.numRecordsInArray; n++ {
            
            var tempImage: UIImage!
            
            if (n % 7 == 0) { tempImage = UIImage(named: "audiophile7")! }
            else if (n % 6 == 0) { tempImage = UIImage(named: "audiophile6")! }
            else if (n % 5 == 0) { tempImage = UIImage(named: "audiophile5")! }
            else if (n % 4 == 0) { tempImage = UIImage(named: "audiophile4")! }
            else if (n % 3 == 0) { tempImage = UIImage(named: "audiophile3")! }
            else if (n % 2 == 0) { tempImage = UIImage(named: "audiophile2")! }
            else if (n % 1 == 0) { tempImage = UIImage(named: "audiophile1")! }
            
            eventItems.append(EventItem(text: "text", desc: String(n), id: Int(1), venueName: "venueName", date: "date", location: "location", city: "city", artist: "artist", image: tempImage ))
        }
        
        //println(eventItems)
        
        toasterView.layer.cornerRadius = toasterView.frame.width/2
        toasterView.hidden = true
        

        
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
            
        })
        
        //eventTableView.backgroundColor = UIColor.blackColor()
        
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
        })
        
        //eventTableView.backgroundColor = UIColor.blackColor()
        
        showHideToaster()
        
        
    }
    

    func showHideToaster(){
        
        toasterView.hidden = false
        toasterView.alpha = 0.8
        
        UIView.animateWithDuration(1.5, animations: { () -> Void in
        
            self.toasterView.alpha = 0.0
            
        })
        
        
        
        
    }

    

}
