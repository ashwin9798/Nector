//
//  messageViewController.swift
//  Bro
//
//  Created by Sachin Saxena on 10/22/16.
//  Copyright © 2016 HackLAds. All rights reserved.
//

import UIKit
import Firebase

class messageViewController: UIViewController {

    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    
    let myRef:FIRDatabaseReference = FIRDatabase.database().reference().child("\(keys)").child("match")

    var users = [userObject]()
    
    var count = 1
    
    var matchSelectKey = ""
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var label1: UILabel!
    
    @IBOutlet var button2: UIButton!
    @IBOutlet var label2: UILabel!
    
    @IBOutlet var button3: UIButton!
    @IBOutlet var label3: UILabel!
    
    @IBOutlet var button4: UIButton!
    @IBOutlet var label4: UILabel!
    
    @IBOutlet var button5: UIButton!
    @IBOutlet var label5: UILabel!
    
    @IBOutlet var button6: UIButton!
    @IBOutlet var label6: UILabel!
    
    @IBOutlet var label7: UILabel!
    @IBOutlet var button7: UIButton!
    
    @IBOutlet var button8: UIButton!
    @IBOutlet var label8: UILabel!
    
    @IBOutlet var button9: UIButton!
    @IBOutlet var label9: UILabel!
    
    @IBOutlet var connect: UILabel!
    @IBOutlet var meet: UILabel!
    @IBOutlet var discover: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            ref.observe(FIRDataEventType.childAdded) { (snapshot: FIRDataSnapshot) in
            
            if !snapshot.exists()
            {
                print("Data snapshot doesn't exist...")
                return
            }
            
            let user = userObject(snapshot: snapshot)

            if user.key != keys
            {
                switch (self.count)
                {
                case 1: self.label1.isHidden = false; self.label1.text = user.message; self.button1.isHidden = false; self.matchSelectKey = user.key; break;
                    case 2: self.label2.isHidden = false; self.label2.text = user.message; self.button2.isHidden = false; self.matchSelectKey = user.key;break;
                    case 3: self.label3.isHidden = false; self.label3.text = user.message; self.button3.isHidden = false; self.matchSelectKey = user.key;break;
                    case 4: self.label4.isHidden = false; self.label4.text = user.message; self.button4.isHidden = false; self.connect.isHidden = false; self.matchSelectKey = user.key;break;
                    case 5: self.label5.isHidden = false; self.label5.text = user.message; self.button5.isHidden = false; self.matchSelectKey = user.key;break;
                    case 6: self.label6.isHidden = false; self.label6.text = user.message; self.button6.isHidden = false; self.matchSelectKey = user.key;break;
                    case 7: self.label7.isHidden = false; self.label7.text = user.message; self.button7.isHidden = false; self.discover.isHidden = false; self.matchSelectKey = user.key;break;
                    case 8: self.label8.isHidden = false; self.label8.text = user.message; self.button8.isHidden = false; self.matchSelectKey = user.key;break;
                    case 9: self.label9.isHidden = false; self.label9.text = user.message; self.button9.isHidden = false; self.meet.isHidden = false; self.matchSelectKey = user.key;break;
                    default: break;
                }
             
                self.count = self.count + 1
            }
        }
        
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
                    self.performSegue(withIdentifier: "toResult", sender: self)
                    
                }
                else
                {
                    print("No Matches... Yet")
                }
            }

        })
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func button1Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label1.text!
        self.ref.child("\(matchSelectKey)/match").setValue(true)
    }
    
    @IBAction func button2Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label2.text!
        self.ref.child("\(matchSelectKey)/match").setValue(true)
    }
    
    @IBAction func button3Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label3.text!
        self.ref.child("\(matchSelectKey)/match").setValue(true)
    }
    @IBAction func button4Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label4.text!
        self.ref.child("\(matchSelectKey)/match").setValue(true)
    }
    @IBAction func button5Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label5.text!
        self.ref.child("\(matchSelectKey)/match").setValue(true)
    }
    @IBAction func button6Tap(_ sender: Any) {
        
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label6.text!
        self.ref.child("\(matchSelectKey)/match").setValue(true)
    }
    
    @IBAction func button7Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label7.text!
        self.ref.child("\(matchSelectKey)/match").setValue(true)
    }
    @IBAction func button8Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label8.text!
        self.ref.child("\(matchSelectKey)/match").setValue(true)
    }
    @IBAction func button9Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label9.text!
        self.ref.child("\(matchSelectKey)/match").setValue(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*
     let label = UILabel(frame: CGRect(x: 0, y: 0, width: 283, height: 30))
     label.font = UIFont.preferredFont(forTextStyle: .headline)
     label.font = label.font.withSize(25)
     label.center = CGPoint(x: 100, y: self.y)
     label.textAlignment = .center
     label.text = user.message
     self.view.addSubview(label)
     
     self.y = self.y + 50
     
     let btn: UIButton = UIButton(frame: CGRect(x: 160, y: self.y, width: 100, height: 50))
     btn.setTitle(user.message, for: .normal)
     btn.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
     btn.tag = self.count
     self.view.addSubview(btn)
     
     self.count = self.count + 1
     self.y = self.y + 50 */

    /*func buttonAction(sender: UIButton!)
     {
     var btnsendtag: UIButton = sender
     print ("\(btnsendtag) was tapped.")
     
     if btnsendtag.tag == 1 {
     }
     }*/


}

