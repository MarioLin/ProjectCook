//
//  YummlyRecipeDetailTransaction.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 6/11/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation

class YummlyRecipeDetailTransacation : ApiTransaction {
    fileprivate let base_url = "https://api.yummly.com/v1/api/"
    
    func makeRecipeRequest(recipeId: String) {
        var defaultParams = [String:String]()
        defaultParams["_app_id"] = yummly_app_id
        defaultParams["_app_key"] = yummly_app_key
        self.params = defaultParams
        self.url = URL(string: base_url + "recipe/" + recipeId)
        makeNetworkRequest()
    }

    override func saveObjectsFromDict(dictionary: [String : Any]) -> [Any] {
        return [RecipeModel(recipeDict: dictionary)]
    }
}
