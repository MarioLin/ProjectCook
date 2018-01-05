//
//  CustomizationTableViewCell.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 1/4/18.
//  Copyright © 2018 Mario Lin. All rights reserved.
//

import UIKit

class CustomizationTableViewCell: UITableViewCell {
    var valueChangedBlock: ((_ isOn: Bool) -> ())?
    
    @IBOutlet weak var customizationLabel: UILabel!
    @IBOutlet weak var customizationSwitch: UISwitch!
    @IBAction func switchValueChanged(_ sender: Any) {
        guard let sender = sender as? UISwitch else { return }
        self.valueChangedBlock?(sender.isOn)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customizationSwitch.tintColor = .yummyOrange
        customizationSwitch.onTintColor = .yummyOrange
    }
}
