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
    let servings: String?
    let cuisine: String?
    let rating: Int?
}

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet var starButtons: [UIImageView]!
    
    @IBOutlet weak var descriptionLabel: UILabel!
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
        if let servings = model.servings {
            descriptionLabel.text = servings.count < 8 ? "\(servings) servings" : servings
        } else {
            descriptionLabel.text = "No serving info"
        }
        
        for star in starButtons {
            if star.tag + 1 <= model.rating ?? 1 {
                star.image = #imageLiteral(resourceName: "filled_star").imageWithColor(color: .yummyOrange)
            } else {
                star.image = #imageLiteral(resourceName: "empty_star").imageWithColor(color: .yummyOrange)
            }
        }
        
    }
}
