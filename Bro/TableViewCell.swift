//
//  TableViewCell.swift
//  Bro
//
//  Created by Sachin Saxena on 10/22/16.
//  Copyright © 2016 HackLAds. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var messageText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
