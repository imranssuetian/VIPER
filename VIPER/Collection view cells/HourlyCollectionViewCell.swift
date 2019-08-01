//
//  HourlyCollectionViewCell.swift
//  VIPER
//
//  Created by Imran Shah on 22/07/2019.
//  Copyright © 2019 Imran Shah. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var tempImage: UIImageView!
    @IBOutlet weak var temp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
