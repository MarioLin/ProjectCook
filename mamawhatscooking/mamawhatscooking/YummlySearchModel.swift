//
//  YummlySearchModel.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 5/14/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation

class YummlySearchModel {
    var imageUrl: String?
    var smallImageUrls: [String]?

    
    var ingredients: [String]?
    var recipeId: String?
    var flavorRating: FlavorsModel?
    var rating: Int?
    var recipeName: String?
    var timeInSeconds: Int?
    
    init?(withDictionary dict:[String:Any]) {
        if let urlSize = dict["imageUrlsBySize"] as? [String:String] {
            imageUrl = urlSize["90"]
        }
        smallImageUrls = dict["smallImageUrls"] as? [String]
        
        guard let id = dict["id"] as? String,
            let name = dict["recipeName"] as? String,
            let time = dict["totalTimeInSeconds"] as? Int,
            let rate = dict["rating"] as? Int,
            let ing = dict["ingredients"] as? [String] else {
            print ("missing key fields")
            return
        }
        recipeId = id
        rating = rate
        recipeName = name
        timeInSeconds = time
        ingredients = ing
        if let flavorsDict = dict["flavors"] as? [String:Float] {
            flavorRating = FlavorsModel(spicyRating: flavorsDict["piquant"],
                                        meatyRating: flavorsDict["meaty"],
                                        bitterRating: flavorsDict["bitter"],
                                        sweetRating: flavorsDict["sweet"],
                                        sourRating: flavorsDict["sour"],
                                        saltRating: flavorsDict["salty"])
        }
    }
}

extension YummlySearchModel: CustomStringConvertible {
    var description: String {
        return recipeId ?? "no id found"
    }
}
