//
//  HomeViewController.swift
//  TeamAudiophile
//
//  Created by Vuhuan Pham on 3/18/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var eventTableView: UITableView!
    
    
    var startingEventCenter: CGPoint!
    var startingViewCenter: CGPoint!
    
    var movies = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.rowHeight = 150
        
        
        movies = ["the last samarai", "taken", "bond 007", "house of cards", "dexter"]
        
        eventTableView.allowsSelection = false
        //eventTableView.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as EventCell
        
        cell.eventName.text = String(indexPath.row)
        
        return cell
    }
    
    

    

}
