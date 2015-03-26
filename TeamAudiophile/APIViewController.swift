//
//  APIViewController.swift
//  TeamAudiophile
//
//  Created by Paul Chong on 3/18/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit
import Parse

class APIViewController: UIViewController {

    var api_key: String!
    var events: NSDictionary!
    var eventDescriptions: [String] = []
    var eventIDs: [Int] = []
    var eventDates: [String] = []
    var eventVenues: [String] = []
    var eventCities: [String] = []
    var eventArtists: [String] = []
    var status: String!
    var numRecordsInArray = 20
    
    
    var parseEventItems: [PFObject]! = []
    var parseEvent = PFObject(className: "EventTest")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api_key = "AOSicvmAJMT3cJCp"
        
        
        
        var url = NSURL(string: "http://api.songkick.com/api/3.0/metro_areas/26330/calendar.json?apikey=\(api_key)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
        
            var dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
       
            self.events = dictionary["resultsPage"]?["results"]? as NSDictionary
            
            
            for var i = 0; i < self.numRecordsInArray; i++
            {
                
                
                
                var eventDesc = self.events["event"]?[i]?["displayName"] as String
                self.eventDescriptions.append(eventDesc)
                
                var eventID = self.events["event"]?[i]?["id"] as Int
                self.eventIDs.append(eventID)
                
                var eventVenue = self.events["event"]?[i]?["venue"]? as NSDictionary
                var eventVenueName = eventVenue["displayName"] as String
                self.eventVenues.append(eventVenueName)
                
                var eventStart = self.events["event"]?[i]?["start"]? as NSDictionary
                var eventDate = eventStart["date"]? as String
                self.eventDates.append(eventDate)
                
                var eventLocation = self.events["event"]?[i]?["location"]? as NSDictionary
                var eventCity = eventLocation["city"]? as String
                self.eventCities.append(eventCity)
                
                var eventPerformance = self.events["event"]?[i]?["performance"]? as NSArray
                var eventArtistName = eventPerformance[0]["displayName"] as String
                self.eventArtists.append(eventArtistName)
                
                
                self.parseEvent["userUID"] = PFUser.currentUser().username as String
                self.parseEvent["userID"] = PFUser.currentUser()
                self.parseEvent["eventIDs"] = self.eventIDs
                self.parseEvent["eventDescriptions"] = self.eventDescriptions
                self.parseEvent["eventDates"] = self.eventDates
                self.parseEvent["eventVenues"] = self.eventVenues
                self.parseEvent["eventCities"] = self.eventCities
                self.parseEvent["eventArtists"] = self.eventArtists
                self.parseEvent.saveInBackgroundWithBlock { (success: Bool!, error: NSError!) -> Void in
                    self.getParseEvents()
                }
                
            }
            
            
        }
        
        getParseEvents()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getParseEvents(){
        var query = PFQuery(className: "EventTest")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            self.parseEventItems = objects as [PFObject]
            
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
