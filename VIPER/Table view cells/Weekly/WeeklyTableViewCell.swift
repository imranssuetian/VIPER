//
//  WeeklyTableViewCell.swift
//  VIPER
//
//  Created by Imran Shah on 22/07/2019.
//  Copyright © 2019 Imran Shah. All rights reserved.
//

import UIKit

class WeeklyTableViewCell: UITableViewCell {

    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var tempImage: UIImageView!
    @IBOutlet weak var lowestTemp: UILabel!
    @IBOutlet weak var highestTemp: UILabel!
    
    @IBOutlet weak var seperator: UIView!
    @IBOutlet weak var weeklyView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
