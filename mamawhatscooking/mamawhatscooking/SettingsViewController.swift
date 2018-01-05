//
//  SettingsViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 1/4/18.
//  Copyright © 2018 Mario Lin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exitButton.setImage(#imageLiteral(resourceName: "exit").imageWithColor(color: .yummyOrange), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
