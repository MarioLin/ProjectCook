//
//  YummlyApiTransaction.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 5/13/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation

class YummlyApiTransaction: ApiTransaction {
    fileprivate let app_key = "29f3f4209293981e065501ac922aeba4"
    fileprivate let app_id = "e7510037"
    fileprivate let base_url = "https://api.yummly.com/v1/api/"
    
    func makeSearchRequest(params: Dictionary<String, String>) {
        var defaultParams = [String:String]()
        defaultParams["_app_id"] = app_id
        defaultParams["_app_key"] = app_key
        for (k,v) in params {
            defaultParams[k] = v
        }
        self.params = defaultParams
        self.url = URL(string: base_url + "recipes")
        makeNetworkRequest()
    }
    
    func makeRecipeRequest(recipeId: String) {
        params = ["_app_id" : app_id]
    }
}
