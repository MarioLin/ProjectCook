//
//  YummlyApiTransaction.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 5/13/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation

class YummlyApiTransaction: NSObject {
    fileprivate let app_key = "29f3f4209293981e065501ac922aeba4"
    fileprivate let app_id = "e7510037"
    fileprivate let base_url = "http://api.yummly.com/v1/api/"
    
    func makeSearchRequest(params: Dictionary<String, String>) {
        var params = params
        let apiTransaction = ApiTransaction()
        params["_app_id"] = app_id
        params["_app_key"] = app_key
        apiTransaction.params = params
        apiTransaction.url = URL(string: base_url + "recipes")
        
    }
}
