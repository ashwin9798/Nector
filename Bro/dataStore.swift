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
    let selected: Bool
    let timeStamp: String
    let IP: String
    let device: String
    let uid: String
    
    init (message: String, lat: Double, long: Double, selected: Bool)
    {
        var timeStampResult: TimeInterval {
            return Date().timeIntervalSince1970
        }
        
        self.message = message
        self.lat = lat
        self.long = long
        self.selected = selected
        self.timeStamp = "\(timeStampResult)"
        self.IP = IPChecker.getIP()
        self.device = "\(Device())"
        self.uid = UIDevice.current.identifierForVendor!.uuidString
    }
    
    func getSnapshotValue() -> NSDictionary {
        return ["timeStamp": timeStamp, "message": message, "lat": lat, "long": long, "selected": selected, "IP": IP, "device": device, "uid": uid]
    }
}
