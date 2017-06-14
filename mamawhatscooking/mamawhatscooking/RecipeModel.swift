//
//  RecipeModel.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 6/11/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation

class RecipeModel {
    let recipeName: String
    let recipeId: String
    var prepTime: Int? // in seconds
    var cookTime: Int? // in seconds
    var totalTime: Int?
    var flavors: FlavorsModel?
    var ingredients: [String]?
//    let nutritionModel: NutritionModel?
    var smallImageUrl: String?
    var largeImageUrl: String?
    init(recipeDict: [String : Any]) {
        recipeName = recipeDict["name"] as! String
        recipeId = recipeDict["id"] as! String
        
        prepTime = recipeDict["prepTimeInSeconds"] as? Int
        cookTime = recipeDict["cookTimeInSeconds"] as? Int
        totalTime = recipeDict["totalTimeInSeconds"] as? Int

        if let flavorsDict = recipeDict["flavors"] as? [String : Float] {
            flavors = FlavorsModel(spicyRating: flavorsDict["piquant"],
                                   meatyRating: flavorsDict["meaty"],
                                   bitterRating: flavorsDict["bitter"],
                                   sweetRating: flavorsDict["sweet"],
                                   sourRating: flavorsDict["sour"],
                                   saltRating: flavorsDict["salty"])

        }
        ingredients = recipeDict["ingredientLines"] as? [String]
        if let imageArray = recipeDict["images"] as? [[String : Any]?] {
            if imageArray.count > 0, let imageDict = imageArray[0] {
                smallImageUrl = imageDict["hostedSmallUrl"] as? String
                largeImageUrl = imageDict["hostedLargeUrl"] as? String
            }
        }
    }
}
