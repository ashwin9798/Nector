//
//  user.swift
//  Bro
//
//  Created by Sachin Saxena on 10/29/16.
//  Copyright © 2016 HackLAds. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class userObject: NSObject {
    
    let key: String
    let lat: Double
    let long: Double
    let match: String
    let message: String
    let selected: Bool
    
    let kmessage = "message"
    let kmatch = "match"
    let klat = "lat"
    let klong = "long"
    let kselected = "selected"

    
    init (key: String, message: String, match: String, lat: Double, long: Double, selected: Bool)
    {
        self.key = key
        self.message = message
        self.match = match
        self.lat = lat
        self.long = long
        self.selected = selected
    }
    
    init(snapshot: FIRDataSnapshot)
    {
        self.key = snapshot.key
        self.message = (snapshot.value as! NSDictionary)[self.kmessage] as! String
        self.match = (snapshot.value as! NSDictionary)[self.kmatch] as! String
        self.lat = (snapshot.value as! NSDictionary)[self.klat] as! Double
        self.long = (snapshot.value as! NSDictionary)[self.klong] as! Double
        self.selected = (snapshot.value as! NSDictionary)[self.kselected] as! Bool
    }
    
    func getSnapshotValue() -> NSDictionary {
        return ["match": match, "message": message, "lat": lat, "long": long, "selected": selected]
    }
}
