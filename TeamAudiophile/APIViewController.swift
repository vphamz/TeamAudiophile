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
    var eventDescription: String!
    var status: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api_key = "AOSicvmAJMT3cJCp"
        
//        api_key = "9e6b4e76d9e83ee879cf684b72d29831"
//        var url = NSURL(string: "http://ws.audioscrobbler.com/2.0/?method=event.getinfo&event=328799&api_key=\(api_key)&format=json")!
        
        
        var url = NSURL(string: "http://api.songkick.com/api/3.0/metro_areas/26330/calendar.json?apikey=\(api_key)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
        var dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
        self.events = dictionary["resultsPage"]?["results"]? as NSDictionary
//        self.status = dictionary["resultsPage"]?["status"]? as String
//        println(self.events)
        self.eventDescription = self.events["event"]?[0]?["displayName"] as String
        println(self.eventDescription)

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
