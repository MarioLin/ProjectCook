//
//  SourceTableViewCell.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/18/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

class SourceCellModel {
    let recipeCreator: String
    let touchBlock: TouchBlock
    init(recipeCreator: String, touchBlock: @escaping TouchBlock) {
        self.recipeCreator = recipeCreator
        self.touchBlock = touchBlock
    }
}

class SourceTableViewCell: UITableViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var recipeSourceButton: RoundedBurritoButton!
    func configure(model: SourceCellModel) {
        authorLabel.text = "Recipe created by: \(model.recipeCreator)"
        recipeSourceButton.touchUpInsideBlock = model.touchBlock
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorLabel.text = nil
        recipeSourceButton.touchUpInsideBlock = nil
    }
}
