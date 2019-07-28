//
//  DetailsTableViewCell.swift
//  VIPER
//
//  Created by macintosh on 22/07/2019.
//  Copyright © 2019 macintosh. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var topLabel1: UILabel!
    @IBOutlet weak var bottomLabel1: UILabel!
    
    @IBOutlet weak var topLabel2: UILabel!
    @IBOutlet weak var bottomLabel2: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
