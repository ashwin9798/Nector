//
//  wordFeedVC.swift
//  Bro
//
//  Created by Sachin Saxena on 12/17/16.
//  Copyright © 2016 HackLAds. All rights reserved.
//

import UIKit
import Firebase

var displayColor = UIColor.black

class wordFeedVC: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    
    var ArrayOfWords = [String]()
    var ArrayOfKeys = [String]()
    var count = 0
    var UserKey: String = ""
    var height: Int = 0
    var ArrayOfButtons = [UIButton]()
    var ArrayOfColors = [UIColor.black, UIColor.blue, UIColor.cyan, UIColor.gray, UIColor.green, UIColor.orange, UIColor.purple, UIColor.red]
    
    
    var whichButtonDeleted: Int = 0
    var whichButtonDeleted1:Int = 0
    
    var whichButtonEmpty: Int = 0
    var buttonIsEmpty: Bool = false
    var colorGenerated: Int = 0
    
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    var myRef: FIRDatabaseReference = FIRDatabase.database().reference().child(keys).child("selected")
    var myRef1: FIRDatabaseReference = FIRDatabase.database().reference().child(keys).child("match")
    
    
    @IBOutlet var errLabel1: UILabel!
    @IBOutlet var errLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref.observe(.childAdded, with: {(snapshot) in
            
            let myKey = snapshot.key
            
            let user = userObject(snapshot: snapshot)
            
            let userMessage = user.message as String?
            
            if userMessage != nil{
                
                if(myKey != self.UserKey)// && self.withinRadius(lat1: user.lat, lon1: user.long, lat2: latitude, lon2: longitude, rad: 50))
                {
                    for index in 0...self.ArrayOfKeys.count-1{
                        if (self.ArrayOfKeys[index] == "0"){
                            self.whichButtonEmpty = index;
                            self.buttonIsEmpty = true
                            self.ArrayOfKeys[index] = myKey
                            self.ArrayOfWords[index] = userMessage!
                            break
                        }
                    }
                    
                    if(!self.buttonIsEmpty){
                        self.ArrayOfWords.append(userMessage!)
                        self.ArrayOfKeys.append(myKey)
                    }
                    
                    if (self.whichButtonEmpty != 0){
                        switch(self.whichColumn(argument: self.whichButtonEmpty)){
                        case 1:
                            self.createButton(xPos: 9, yPos: (((((self.whichButtonEmpty+1)/3)-1)*131)+15), message: userMessage!);
                            
                            self.height = (((((self.count+3)/4)-1)*266)+13) + 110;
                            break
                        case 2:
                            self.createButton(xPos: 117, yPos: ((((self.whichButtonEmpty+2/3)-1)*131)+80), message: userMessage!);
                            
                            self.height = ((((self.count/2)-1)*130)+81) + 110
                            break
                        case 3:
                            self.createButton(xPos: 225, yPos: (((((self.whichButtonEmpty)/3)-1)*131)+144), message: userMessage!);
                            self.height = (((((self.count+1)/4)-1)*131)+145) + 110
                            break
                        default:
                            break
                        }
                        
                    }
                        
                    else{
                        self.count += 1
                        
                        switch(self.whichColumn(argument: self.count)){
                        case 1:
                            self.createButton(xPos: 9, yPos: (((((self.count+1)/3)-1)*131)+80), message: userMessage!);
                            
                            self.height = (((((self.count+3)/4)-1)*266)+13) + 110;
                            break
                        case 2:
                            self.createButton(xPos: 117, yPos: (((((self.count+2)/3)-1)*131)+15), message: userMessage!);
                            
                            self.height = ((((self.count/2)-1)*130)+81) + 110
                            break
                        case 3:
                            self.createButton(xPos: 225, yPos: (((((self.count)/3)-1)*131)+80), message: userMessage!);
                            self.height = (((((self.count+1)/4)-1)*266)+145) + 110
                            break
                        default:
                            break
                        }
                    }
                    
                    self.scrollView.contentSize.height = CGFloat(self.height)
                    self.buttonIsEmpty = false
                    
                }
            }
            
        })
        
        ref.observe(.childRemoved, with: {(snapshot) in
            
            let matchedUserKey = snapshot.key
            
            if matchedUserKey != self.UserKey {
                
                for index in 0...self.ArrayOfKeys.count-1{
                    if(matchedUserKey == self.ArrayOfKeys[index]){
                        
                        let buttonToDelete = self.ArrayOfButtons[index-1]
                        buttonToDelete.removeFromSuperview()
                        self.ArrayOfKeys[index] = "0"
                    }
                }
                
            }
            
        })
        
        self.myRef1.observe(FIRDataEventType.value, with: { (snapshot) in
            
            if !snapshot.exists(){
                print("waiting on color")
            }
                
            else{
                
                let color = snapshot.value as! String
                
                switch(color){
                case "0":
                    displayColor = self.ArrayOfColors[0]
                    break
                case "1":
                    displayColor = self.ArrayOfColors[1]
                    break
                case "2":
                    displayColor = self.ArrayOfColors[2]
                    break
                case "3":
                    displayColor = self.ArrayOfColors[3]
                    break
                case "4":
                    displayColor = self.ArrayOfColors[4]
                    break
                case "5":
                    displayColor = self.ArrayOfColors[5]
                    break
                case "6":
                    displayColor = self.ArrayOfColors[6]
                    break
                case "7":
                    displayColor = self.ArrayOfColors[7]
                    break
                default:
                    break
                    
                }
            }
        })
        
        myRef.observe(FIRDataEventType.value, with: { (snapshot) in
            if !snapshot.exists()
            {
                print("Data snapshot doesn't exist...")
                return
            }
                
            else
            {
                let decision = snapshot.value as! Bool
                if (decision)
                {
                    print("Match Complete")
                    
                    displayMessage = self.ArrayOfWords[0]
                    
                    self.performSegue(withIdentifier: "toMatch", sender: Any?.self)
                    self.ref.child(self.UserKey).removeValue()
                    
                }
                else
                {
                    print("No Matches... Yet")
                }
    
            }
            
        })
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func createButton(xPos: Int, yPos: Int, message: String){
        
        let button = UIButton(frame: CGRect(x: xPos, y: yPos, width: 139, height: 126))
        button.setBackgroundImage(#imageLiteral(resourceName: "HexagonLastScreen"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        button.setTitle(message, for: UIControlState.normal)
        button.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        button.tag = self.count      //tag is the same as index positions in arrays
        //ArrayOfButtons.append(button)
        self.view.addSubview(button)
        
        if(self.buttonIsEmpty == true){
            button.tag = self.whichButtonEmpty
            ArrayOfButtons[self.whichButtonEmpty] = button
        }
        else{
            button.tag = self.count
            ArrayOfButtons.append(button)
            
        }
        
    }
    
    func buttonAction(sender: UIButton!){
        
        let buttonTag: UIButton = sender
        
        for index in 0...self.count{
            
            if((self.ArrayOfWords[index] == buttonTag.currentTitle) && buttonTag.tag == index){
                let key = ArrayOfKeys[index]
                
                displayMessage = ArrayOfWords[index]
                self.colorGenerated = Int(arc4random_uniform(8))
                displayColor = self.ArrayOfColors[colorGenerated]
                
                ref.child(key).child("match").setValue("\(self.colorGenerated)")
                ref.child(key).child("selected").setValue(true)
                //ref.child(self.UserKey).child("match").setValue("\(self.colorGenerated)")
                ref.child(self.UserKey).removeValue()
                performSegue(withIdentifier: "toMatch", sender: Any?.self)
            }
        }
        whichButtonDeleted = buttonTag.tag
    }
    
    func whichColumn(argument: Int)->Int{
        
        if((argument+2)%3 == 0){
            return 2
        }
        else if(argument%3 == 0) {
            return 3
        }
        return 1
    }
    
    func withinRadius(lat1: Double, lon1: Double, lat2: Double, lon2: Double, rad: Double) -> Bool
    {
        let R = 6371.0; // km
        let dLat = toRad(degrees: lat2-lat1);
        let dLon = toRad(degrees: lon2-lon1);
        let lat1 = toRad(degrees: lat1);
        let lat2 = toRad(degrees: lat2);
        
        let a = sin(dLat/2) * sin(dLat/2) + sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2);
        let c = 2 * atan2(sqrt(a), sqrt(1-a));
        let d = R * c;
        
        print ("Distance: \(d*1000)")
        return (d*1000 < rad)
    }
    
    func toRad(degrees: Double) -> Double
    {
        return degrees * 22/7/180
    }
    


    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Remove Firebase Observers
        
        ref.removeAllObservers()
        myRef.removeAllObservers()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
