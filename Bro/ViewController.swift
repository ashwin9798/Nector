//
//  ViewController.swift
//  Bro
//
//  Created by Sachin Saxena on 10/29/16.
//  Copyright © 2016 HackLAds. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

var keys = ""
var displayMessage = ""

var latitude:CLLocationDegrees = 0.0
var longitude:CLLocationDegrees = 0.0


class ViewController: UIViewController, CLLocationManagerDelegate
{

    @IBOutlet var messageText: UITextField!
    
    var ref: FIRDatabaseReference!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        manager.delegate = self
        manager.requestLocation()
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            print("Found user's lat: \(location.coordinate.latitude)")
            print("Found user's long: \(location.coordinate.longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
    
    
    @IBAction func breakTheIce(_ sender: Any)
    {
        keys = ref.childByAutoId().key
        
        displayMessage = messageText.text!
        
        let user = userObject(key: keys, message: messageText.text!, match: false, lat: latitude, long: longitude)
        
        let childUpdates = ["/\(keys)/" : user.getSnapshotValue()]
        
        ref.updateChildValues(childUpdates)
        
        self.performSegue(withIdentifier: "toList", sender: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}

