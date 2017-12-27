//
//  AttributionTableViewCell.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/27/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

class AttributionTableViewCell: UITableViewCell {

    @IBOutlet weak var poweredByLabel: UILabel!
    @IBOutlet weak var attributionLogo: UIImageView!

    @IBOutlet weak var fullRecipeBtn: UIButton!
    func configure(model: AttributionModel) {
        poweredByLabel.text = model.text
        
        if attributionLogo.image == nil, let logo = model.logo {
            attributionLogo.downloadImage(link: logo)
        }
        fullRecipeBtn.titleLabel?.textAlignment = .center
        fullRecipeBtn.setTouchBlock { (sender) in
            
        }
    }
}
