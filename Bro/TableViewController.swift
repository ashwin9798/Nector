//
//  TableViewController.swift
//  Bro
//
//  Created by Sachin Saxena on 10/22/16.
//  Copyright © 2016 HackLAds. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {

    var ref: FIRDatabaseReference!
    var users = [userObject]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
        users.removeAll()
        
        ref.observe(FIRDataEventType.childAdded) { (snapshot: FIRDataSnapshot) in
            
            if !snapshot.exists()
            {
                print("Data snapshot doesn't exist...")
                return
            }
            
            let user = userObject(snapshot: snapshot)
            
            if user.key != keys
            {
                self.users.insert(user, at: 0)
                if (self.users.count == 1) {
                    self.tableView.reloadData()
                } else {
                    let indexPath = NSIndexPath(row: 0, section: 0)
                    self.tableView.insertRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
                }
            }
        
            self.ref.observe(FIRDataEventType.childRemoved) { (snapshot: FIRDataSnapshot) in
                
                let userToDelete = userObject(snapshot: snapshot)
                
                var indexToRemove: Int!
                
                for userID in self.users
                {
                    print (userID.key)
                    print (userToDelete.key)
                    
                    if userID.key == userToDelete.key
                    {
                        indexToRemove = self.users.index(of: userID)
                        
                        self.users.remove(at: indexToRemove!)
                        break
                    }
                }
                
                /*if self.users.count == 0 {
                    self.tableView.reloadData()
                    self.setEditing(false, animated: true)
                } else {
                    let indexPath = NSIndexPath(row: indexToRemove, section: 0)
                    self.tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
                }*/
            }
            
        

            
            /*for elements: userObject in self.users
            {
                if elements
            }
            
            if (user.lat - (self.ref.value(forKeyPath: "\(keys)/lat") as! Double) <= 0.000001)
            {
                self.users.insert(user, at: 0)
                
                if (self.users.count == 1) {
                    self.tableView.reloadData()
                } else {
                    let indexPath = NSIndexPath(row: 0, section: 0)
                    self.tableView.insertRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
                }
                
            }*/
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return max(users.count, 1)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell
        
        if users.count == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "noCell", for: indexPath as IndexPath) 
        }
            
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) 
            let user = users[indexPath.row]
            cell.textLabel?.text = user.message
        }

        // Configure the cell...

        return cell
    }

    
    @IBAction func removeUser(_ sender: Any) {
        ref.child(keys).removeValue()
        self.performSegue(withIdentifier: "toHome", sender: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Remove Firebase Observers
        
        ref.removeAllObservers()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
 
    
    @IBAction func onClickBack(_ sender: Any) {
        ref = FIRDatabase.database().reference()
        print(ref.child(keys))
        print("BACK ON")
        ref.child(keys).removeValue()
        //self.performSegue(withIdentifier: "toMain", sender: self)
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
