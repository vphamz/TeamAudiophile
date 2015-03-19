//
//  APIViewController.swift
//  TeamAudiophile
//
//  Created by Paul Chong on 3/18/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit

class APIViewController: UIViewController {

    var api_key: String!
    var events: NSDictionary!
    var eventDescriptions: [String] = []
    var eventIDs: [Int] = []
    var eventDates: [String] = []
    var status: String!
    var numRecordsInArray = 40
    
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
            
//            var eventDate = self.events["event"]?[i]?["start"]?["date"] as String
//            self.eventDates.append(eventDate)
            
        }
            
        println(self.eventIDs)
        println(self.eventDescriptions)
            
        }
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

}
