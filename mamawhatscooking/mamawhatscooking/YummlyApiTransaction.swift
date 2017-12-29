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
    var attributionModel: [String : String]?
    
    func makeSearchRequest(params: Dictionary<String, String>) {
        var defaultParams = [String:String]()
        defaultParams["_app_id"] = yummly_app_id
        defaultParams["_app_key"] = yummly_app_key
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
        dict["requiresPictures"] = "true"
        let keyValuePair = YummlyApiTransaction.courseKeyValuePair(type)
        dict[keyValuePair.0] = keyValuePair.1
        return dict
    }

    private class func courseKeyValuePair(_ type: RecipeCourseType) -> (String, String) {
        let courseKey = "allowedCourse[]"
        switch type {
        case .breakfast:
            return (courseKey, "course^course-Breakfast and Brunch")
        case .lunch:
            return (courseKey, "course^course-Lunch")
        case .dinner:
            return (courseKey, "course^course-Main Dishes")
        case .dessert:
            return (courseKey, "course^course-Desserts")
        case .appetizer:
            return (courseKey, "course^course-Appetizers")
        case .drink:
            return (courseKey, "course^course-Beverages")
        }
    }
    
    override func saveObjectsFromDict(dictionary: [String : Any]) -> [Any] {
        guard let matches = dictionary["matches"] as? [[String : Any]],
            let attribution = dictionary["attribution"] as? [String : String] else { return [] }
        attributionModel = attribution
        let matchModels = matches.flatMap { (matchDict: [String : Any]) -> YummlySearchModel? in
            let model = YummlySearchModel(withDictionary: matchDict)
            return model
        }
        return matchModels
    }
}
