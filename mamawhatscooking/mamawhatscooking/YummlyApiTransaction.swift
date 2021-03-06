//
//  YummlyApiTransaction.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 5/13/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation

class YummlyApiTransaction: ApiTransaction {
    fileprivate let base_url = "https://api.yummly.com/v1/api/"
    var searchAttribution: AttributionModel?
    
    func makeSearchRequest(params: Dictionary<String, String>) {
        var defaultParams = [String:String]()
        defaultParams["_app_id"] = yummly_app_id
        defaultParams["_app_key"] = yummly_app_key
        defaultParams["maxResult"] = "75"
        for (k,v) in params {
            defaultParams[k] = v
        }
        self.params = defaultParams
        self.url = URL(string: base_url + "recipes")
        makeNetworkRequest()
    }
    
    // MARK: Class funcs and overrides
    class func defaultSearchParams(_ type: RecipeCourseType) -> [String : String] {
        var dict = [String : String]()
        dict["requirePictures"] = "true"
        if let keyValuePair = courseKeyValuePair(type) {
            dict[keyValuePair.0] = keyValuePair.1
        }
        return dict
    }
    
    override func saveObjectsFromDict(dictionary: [String : Any]) -> [Any] {
        guard let matches = dictionary["matches"] as? [[String : Any]],
            let attribution = dictionary["attribution"] as? [String : String] else { return [] }
        searchAttribution = AttributionModel(dict: attribution)
        let matchModels = matches.flatMap { (matchDict: [String : Any]) -> YummlySearchModel? in
            let model = YummlySearchModel(withDictionary: matchDict)
            return model
        }
        return matchModels
    }
}
