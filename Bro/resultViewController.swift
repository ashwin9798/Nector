//
//  resultViewController.swift
//  Bro
//
//  Created by Sachin Saxena on 10/29/16.
//  Copyright © 2016 HackLAds. All rights reserved.
//

import UIKit

class resultViewController: UIViewController {

    @IBOutlet var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        result.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        result.text = displayMessage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
