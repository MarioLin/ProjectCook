//
//  RecipeModel.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 6/11/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation

class RecipeModel {
    // core recipe details
    let recipeName: String
    let recipeId: String
    let yield: String

    // recipe time to prep/cook
    var prepTime: Int? // in seconds
    var cookTime: Int? // in seconds
    var totalTime: Int?
    var totalTimeString: String?

    // specific recipe details
    var ingredients: [String]?
    var smallImageUrl: String?
    var largeImageUrl: String?
    
    // credits
    var attributionModel: AttributionModel?
    var sourceModel: SourceModel?
    
    init(recipeDict: [String : Any]) {
        recipeName = recipeDict["name"] as? String ?? ""
        recipeId = recipeDict["id"] as? String ?? ""
        yield = recipeDict["yield"] as? String ?? "No servings"
        prepTime = recipeDict["prepTimeInSeconds"] as? Int
        cookTime = recipeDict["cookTimeInSeconds"] as? Int
        totalTimeString = recipeDict["totalTime"] as? String
        totalTime = recipeDict["totalTimeInSeconds"] as? Int
        ingredients = recipeDict["ingredientLines"] as? [String]
        if let imageArray = recipeDict["images"] as? [[String : Any]?] {
            if imageArray.count > 0, let imageDict = imageArray[0] {
                smallImageUrl = imageDict["hostedSmallUrl"] as? String
                largeImageUrl = imageDict["hostedLargeUrl"] as? String
            }
        }
        
        if let attrDict = recipeDict["attribution"] as? [String : String] {
            attributionModel = AttributionModel(dict: attrDict)
        }
        
        if let srcDict = recipeDict["source"] as? [String : String] {
            sourceModel = SourceModel(dict: srcDict)
        }
        
    }
}
