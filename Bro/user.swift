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
    let match: Bool
    let message: String
    //let radius: CLLocationCoordinate2D
    
    let kmessage = "message"
    let kmatch = "match"
    let klat = "lat"
    let klong = "long"
    
    init (key: String, message: String, match: Bool, lat: Double, long: Double)
    {
        self.key = key
        self.message = message
        self.match = match
        self.lat = lat
        self.long = long
    }
    
    init(snapshot: FIRDataSnapshot)
    {
        self.key = snapshot.key
        self.message = (snapshot.value as! NSDictionary)[self.kmessage] as! String
        self.match = (snapshot.value as! NSDictionary)[self.kmatch] as! Bool
        self.lat = (snapshot.value as! NSDictionary)[self.klat] as! Double
        self.long = (snapshot.value as! NSDictionary)[self.klong] as! Double
    }
    
    func getSnapshotValue() -> NSDictionary {
        return ["match": match, "message": message, "lat": lat, "long": long]//"key": key, "location": location,
    }
}
