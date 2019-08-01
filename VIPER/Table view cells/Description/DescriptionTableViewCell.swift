//
//  DescriptionTableViewCell.swift
//  VIPER
//
//  Created by Imran Shah on 22/07/2019.
//  Copyright © 2019 Imran Shah. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var tempDesc: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
