//
//  YummlyRecipeDetailTransaction.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 6/11/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation

class YummlyRecipeDetailTransacation : ApiTransaction {
    fileprivate let app_key = "29f3f4209293981e065501ac922aeba4"
    fileprivate let app_id = "e7510037"
    fileprivate let base_url = "https://api.yummly.com/v1/api/"
    
    func makeRecipeRequest(recipeId: String) {
        var defaultParams = [String:String]()
        defaultParams["_app_id"] = app_id
        defaultParams["_app_key"] = app_key
        self.params = defaultParams
        self.url = URL(string: base_url + "recipe/" + recipeId)
        makeNetworkRequest()
    }

    override func saveObjectsFromDict(dictionary: [String : Any]) -> [Any] {
        return []
    }
}
