//
//  landingVC.swift
//  Bro
//
//  Created by Sachin Saxena on 12/17/16.
//  Copyright © 2016 HackLAds. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import AudioToolbox

var keys = ""
var displayMessage = ""

var latitude:CLLocationDegrees = 0.0
var longitude:CLLocationDegrees = 0.0

class landingVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var ViewControllerView: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var iceCube: UIButton!
    
    var ref: FIRDatabaseReference!
    var counter = 0
    var ArrayOfOtherUsersWords = [String]()
    
    let whitespace = NSCharacterSet.whitespaces
    let manager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()

        ref = FIRDatabase.database().reference()
        
        manager.delegate = self
        manager.requestLocation()
        
        textField.center.x  -= ViewControllerView.bounds.width
        self.label1.alpha = 0
        self.label2.alpha = 0
        self.iceCube.alpha = 0
        self.label3.alpha = 0
        
        UIView.animate(withDuration: 1.2, delay: 3, animations: {
            self.textField.center.x += self.ViewControllerView.bounds.width
        })
        
        UIView.animate(withDuration: 1.3, delay: 0.5, animations: {
            self.label1.alpha = 1
        })
        
        UIView.animate(withDuration: 1.3, delay: 1.4, animations: {
            self.label2.alpha = 1
        })
        
        UIView.animate(withDuration: 1.5, delay: 4.2, animations: {
            self.iceCube.alpha = 1
        })
        
        UIView.animate(withDuration: 1.5, delay: 5.4, animations: {
            self.label3.alpha = 1
        })

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

    @IBAction func breakTheIce(_ sender: AnyObject) {
        
        let range = textField.text?.rangeOfCharacter(from: whitespace)
        
        if(textField.text?.characters.count == 0){
            
            label3.text = "You forgot to enter a word"
        }
            
        else if(range != nil){

            label3.text = "Only one word, please"
        }
            
        else{
            
            keys = ref.childByAutoId().key
            
            displayMessage = textField.text!
            
            let user = userObject(key: keys, message: textField.text!, match: "", lat: latitude, long: longitude, selected: false)
            
            let childUpdates = ["/\(keys)/" : user.getSnapshotValue()]
            
            ref.updateChildValues(childUpdates)
            
            counter += 1
            
            performSegue(withIdentifier: "toWordFeed", sender: Any?.self)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toWordFeed"){
            //let DestViewController = segue.destination as! UINavigationController
            let MessageData = segue.destination as! wordFeedVC
            
            MessageData.ArrayOfWords.append(textField.text!)
            MessageData.ArrayOfKeys.append(keys)
            MessageData.UserKey = keys
            //MessageData.count = counter
        }
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        textField.resignFirstResponder()
        
    }
}
