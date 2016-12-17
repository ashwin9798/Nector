//
//  matchVC.swift
//  Bro
//
//  Created by Sachin Saxena on 12/17/16.
//  Copyright © 2016 HackLAds. All rights reserved.
//

import UIKit

class matchVC: UIViewController {

    @IBOutlet weak var message: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        message.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        message.text = displayMessage
        view.backgroundColor = displayColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
