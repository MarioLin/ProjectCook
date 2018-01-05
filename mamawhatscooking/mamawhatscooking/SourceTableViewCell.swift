//
//  SourceTableViewCell.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/18/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

struct SourceCellModel {
    let recipeCreator: String
    let totalTimeString: String
    let touchBlock: TouchBlock
}

class SourceTableViewCell: UITableViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var recipeSourceButton: RoundedBurritoButton!
    @IBOutlet weak var cookingTime: UILabel!
    @IBOutlet weak var cookingTimerImageView: UIImageView!
    
    func configure(model: SourceCellModel) {
        authorLabel.text = "Recipe created by: \(model.recipeCreator)"
        recipeSourceButton.touchUpInsideBlock = model.touchBlock
        cookingTime.text = model.totalTimeString
        cookingTimerImageView.image = #imageLiteral(resourceName: "timer").imageWithColor(color: .yummyOrange)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorLabel.text = nil
        recipeSourceButton.touchUpInsideBlock = nil
    }
}
