//
//  RecipeTableViewCell.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/18/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

struct RecipeCellModel {
    let imageString: String
    let title: String
}

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        recipeImageView.image = nil
        label.text = nil
    }
    
    func configure(model: RecipeCellModel) {
        label.text = model.title
        if recipeImageView.image == nil {
            recipeImageView.downloadImage(link: model.imageString)
        }
    }
    
    func height(model: RecipeCellModel) {
        
    }
}
