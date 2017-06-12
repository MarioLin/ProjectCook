//
//  RecipeModel.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 6/11/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation

class RecipeModel {
    var flavors: FlavorsModel?
    var ingredients: [String]?
    var nutritionModel: NutritionModel?
    init(recipeDict: [String : Any]) {
        if let flavorsDict = recipeDict["flavors"] as? [String : Float] {
            flavors = FlavorsModel(spicyRating: flavorsDict["piquant"],
                                   meatyRating: flavorsDict["meaty"],
                                   bitterRating: flavorsDict["bitter"],
                                   sweetRating: flavorsDict["sweet"],
                                   sourRating: flavorsDict["sour"],
                                   saltRating: flavorsDict["salty"])

        }
        if let ingredientLines = recipeDict["ingredientLines"] as? [String] {
            ingredients = ingredientLines
        }
        if let nutrition = recipeDict["nutritionEstimates"] as? [String : Any] {
            nutritionModel = NutritionModel(dict: nutrition)
        }
    }
}
