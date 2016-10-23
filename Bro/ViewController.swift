//
//  ViewController.swift
//  Bro
//
//  Created by Sachin Saxena on 10/21/16.
//  Copyright © 2016 HackLAds. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

var keys = ""
var displayMessage = ""

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var messageText: UITextField!
    
    var ref: FIRDatabaseReference!
    
//    var manager = CLLocationManager()
//    
//    var latitude:CLLocationDegrees = 0.0
//    var longitude:CLLocationDegrees = 0.0
//
//    let locationManager = CLLocationManager()
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
//    {
//        let location = locations.last
//    
//        latitude = location!.coordinate.latitude
//        longitude = location!.coordinate.longitude
//        
//        self.locationManager.stopUpdatingLocation()
//    }

    
    @IBAction func breakTheIce(_ sender: Any) 
    {
        keys = ref.childByAutoId().key
        
        displayMessage = messageText.text!
        
        let user = userObject(key: keys, message: messageText.text!, match: false)//, lat: "\(latitude)", long: "\(longitude)")
        
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

