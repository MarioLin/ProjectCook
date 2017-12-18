//
//  AttributionModel.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 5/14/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation

struct AttributionModel {
    let text: String!
    let logo: String?
    let urlString: String!
    
    init?(dict: [String : String]) {
        text = dict["text"]
        logo = dict["logo"]
        urlString = dict["url"]
        if text == nil || urlString == nil {
            return nil
        }
    }
    
}

extension AttributionModel: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(String(describing: text)), \n\(String(describing: logo)), \n\(String(describing: urlString))"
    }
}

struct SourceModel {
    let displayName: String!
    let siteUrl: String?
    let recipeUrl: String!
    init?(dict: [String : String]) {
        displayName = dict["sourceDisplayName"]
        siteUrl = dict["sourceSiteUrl"]
        recipeUrl = dict["sourceRecipeUrl"]
        if displayName == nil || recipeUrl == nil {
            return nil
        }
    }
}

extension SourceModel: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(String(describing: displayName)), \n\(String(describing: siteUrl)), \n\(String(describing: recipeUrl))"
    }
}

