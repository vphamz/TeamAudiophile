//
//  EventItem.swift
//  TeamAudiophile
//
//  Created by Vuhuan Pham on 3/21/15.
//  Copyright (c) 2015 Vuhuan Pham. All rights reserved.
//

import UIKit

class EventItem: NSObject {
    
    // A text description of this item.
    var text: String
    var desc: String
    var id: Int
    var useruid: String
    var venueName: String
    var date: String
    var location: String
    var city: String
    var artist: String
    var image: UIImage
    
    
    // A Boolean value that determines the completed state of this item.
    var completed: Bool
    
    
    // Returns a ToDoItem initialized with the given text and default completed value.
    
    init(text: String, desc: String, id: Int, useruid: String, venueName: String, date: String, location: String, city: String, artist: String, image: UIImage) {
        self.text = text
        self.desc = desc
        self.id = id
        self.useruid = useruid
        self.venueName = venueName
        self.date = date
        self.location = location
        self.city = city
        self.artist = artist
        self.image = image
        self.completed = false
    }
    
    
   
}


