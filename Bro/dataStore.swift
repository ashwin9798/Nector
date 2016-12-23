//
//  dataStore.swift
//  Bro
//
//  Created by Sachin Saxena on 12/23/16.
//  Copyright © 2016 HackLAds. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import DeviceKit

class dataStore: NSObject {
    
    let lat: Double
    let long: Double
    let message: String
    let timeStamp: String
    let IP: String
    let device: String
    let uid: String
    let loc: String
    let name: String
    let foundMatch: Bool
    let wordSelected: Bool
    
    init (message: String, lat: Double, long: Double, wordSelected: Bool, foundMatch: Bool)
    {
        var timeStampResult: TimeInterval {
            return Date().timeIntervalSince1970
        }
        
        self.message = message
        self.lat = lat
        self.long = long
        self.wordSelected = wordSelected
        self.foundMatch = foundMatch
        self.timeStamp = "\(timeStampResult)"
        self.IP = ipString
        self.device = "\(Device())"
        self.uid = UIDevice.current.identifierForVendor!.uuidString
        self.loc = locString
        self.name = "\(UIDevice.current.name)"
    }
    
    func getSnapshotValue() -> NSDictionary {
        return ["timeStamp": timeStamp, "message": message, "lat": lat, "long": long, "IP": IP, "device": device, "uid": uid, "loc": loc, "name": name, "wordSelected": wordSelected, "foundMatch": foundMatch]
    }
    
}
