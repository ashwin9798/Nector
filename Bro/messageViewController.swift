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
    
    var label1key = ""
    var label2key = ""
    var label3key = ""
    var label4key = ""
    var label5key = ""
    var label6key = ""
    var label7key = ""
    var label8key = ""
    var label9key = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
            ref.observe(FIRDataEventType.childAdded) { (snapshot: FIRDataSnapshot) in
            
            if !snapshot.exists()
            {
                print("Data snapshot doesn't exist...")
                return
            }
            else
            {
                self.error1.isHidden = true
                self.error2.isHidden = true
            }
            
            let user = userObject(snapshot: snapshot)

            if user.key != keys
            {
                switch (self.count)
                {
                case 1: self.label1.isHidden = false; self.label1.text = user.message; self.button1.isHidden = false; self.label1key = user.key; print (user.key); break;
                    case 2: self.label2.isHidden = false; self.label2.text = user.message; self.button2.isHidden = false; self.label2key = user.key;break;
                    case 3: self.label3.isHidden = false; self.label3.text = user.message; self.button3.isHidden = false; self.label3key = user.key;break;
                    case 4: self.label4.isHidden = false; self.label4.text = user.message; self.button4.isHidden = false; self.connect.isHidden = false; self.label4key = user.key;break;
                    case 5: self.label5.isHidden = false; self.label5.text = user.message; self.button5.isHidden = false; self.label5key = user.key;break;
                    case 6: self.label6.isHidden = false; self.label6.text = user.message; self.button6.isHidden = false; self.label6key = user.key;break;
                    case 7: self.label7.isHidden = false; self.label7.text = user.message; self.button7.isHidden = false; self.discover.isHidden = false; self.label7key = user.key;break;
                    case 8: self.label8.isHidden = false; self.label8.text = user.message; self.button8.isHidden = false; self.label8key = user.key;break;
                    case 9: self.label9.isHidden = false; self.label9.text = user.message; self.button9.isHidden = false; self.meet.isHidden = false; self.label9key = user.key;break;
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
                    self.ref.child("\(keys)").removeValue()
                    
                    self.performSegue(withIdentifier: "toResult", sender: self)
                    
                }
                else
                {
                    print("No Matches... Yet")
                }
            }

        })
        
        ref.observe(FIRDataEventType.childRemoved) { (snapshot: FIRDataSnapshot) in
            let userToDelete = userObject(snapshot: snapshot)
            
            if (self.label1.text == userToDelete.message)
            {
                self.label1.isHidden = true; self.button1.isHidden = true;
            }
            else if (self.label2.text == userToDelete.message)
            {
                self.label2.isHidden = true; self.button2.isHidden = true;
            }
            else if (self.label3.text == userToDelete.message)
            {
                self.label3.isHidden = true; self.button3.isHidden = true;
            }
            else if (self.label4.text == userToDelete.message)
            {
                self.label4.isHidden = true; self.button4.isHidden = true;
            }
            else if (self.label5.text == userToDelete.message)
            {
                self.label5.isHidden = true; self.button5.isHidden = true;
            }
            else if (self.label6.text == userToDelete.message)
            {
                self.label6.isHidden = true; self.button6.isHidden = true;
            }
            else if (self.label7.text == userToDelete.message)
            {
                self.label7.isHidden = true; self.button7.isHidden = true;
            }
            else if (self.label8.text == userToDelete.message)
            {
                self.label8.isHidden = true; self.button8.isHidden = true;
            }
            else if (self.label9.text == userToDelete.message)
            {
                self.label9.isHidden = true; self.button9.isHidden = true;
            }
          
            self.errorMessage()
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func button1Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label1.text!
        self.ref.child("\(label1key)/match").setValue(true)
    }
    
    @IBAction func button2Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label2.text!
        self.ref.child("\(label2key)/match").setValue(true)
    }
    
    @IBAction func button3Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label3.text!
        self.ref.child("\(label3key)/match").setValue(true)
    }
    @IBAction func button4Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label4.text!
        self.ref.child("\(label4key)/match").setValue(true)
    }
    @IBAction func button5Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label5.text!
        self.ref.child("\(label5key)/match").setValue(true)
    }
    @IBAction func button6Tap(_ sender: Any) {
        
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label6.text!
        self.ref.child("\(label6key)/match").setValue(true)
    }
    
    @IBAction func button7Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label7.text!
        self.ref.child("\(label7key)/match").setValue(true)
    }
    @IBAction func button8Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label8.text!
        self.ref.child("\(label8key)/match").setValue(true)
    }
    @IBAction func button9Tap(_ sender: Any) {
        self.ref.child("\(keys)/match").setValue(true)
        displayMessage = label9.text!
        self.ref.child("\(label9key)/match").setValue(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Remove Firebase Observers
        
        ref.removeAllObservers()
        myRef.removeAllObservers()
    }
    
    @IBOutlet var error1: UILabel!
    @IBOutlet var error2: UILabel!
    
    func errorMessage() -> Void
    {
        if (label1.isHidden == true && label2.isHidden == true && label3.isHidden == true && label4.isHidden == true && label5.isHidden == true && label6.isHidden == true && label7.isHidden == true && label8.isHidden == true && label9.isHidden == true)
        {
            error1.isHidden = false
            error2.isHidden = false
        }
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

