//
//  TodayTableViewCell.swift
//  VIPER
//
//  Created by macintosh on 22/07/2019.
//  Copyright © 2019 macintosh. All rights reserved.
//

import UIKit

class TodayTableViewCell: UITableViewCell {

    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var day2: UILabel!
    @IBOutlet weak var lowestTemp: UILabel!
    @IBOutlet weak var highestTemp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
