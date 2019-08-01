//
//  DetailsTableViewCell.swift
//  VIPER
//
//  Created by Imran Shah on 22/07/2019.
//  Copyright © 2019 Imran Shah. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var topLabel1: UILabel!
    @IBOutlet weak var bottomLabel1: UILabel!
    
    @IBOutlet weak var topLabel2: UILabel!
    @IBOutlet weak var bottomLabel2: UILabel!

    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    @IBOutlet weak var seperator: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
