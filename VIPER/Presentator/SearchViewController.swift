//
//  SearchViewController.swift
//  VIPER
//
//  Created by macintosh on 01/08/2019.
//  Copyright © 2019 macintosh. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundImage.image = UIImage.gif(url: clear_day)
        searchView.layer.cornerRadius = 10
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search By City",
                                                                   attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
