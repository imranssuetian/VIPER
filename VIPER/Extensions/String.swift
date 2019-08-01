//
//  String.swift
//  VIPER
//
//  Created by Imran Shah on 30/07/2019.
//  Copyright © 2019 Imran Shah. All rights reserved.
//

import Foundation
import UIKit
extension String {
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }
    
}
