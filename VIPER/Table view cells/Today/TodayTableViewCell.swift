//
//  TodayTableViewCell.swift
//  VIPER
//
//  Created by Imran Shah on 22/07/2019.
//  Copyright © 2019 Imran Shah. All rights reserved.
//

import UIKit

class TodayTableViewCell: UITableViewCell {

    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var day2: UILabel!
    @IBOutlet weak var lowestTemp: UILabel!
    @IBOutlet weak var highestTemp: UILabel!
    @IBOutlet weak var todayView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
