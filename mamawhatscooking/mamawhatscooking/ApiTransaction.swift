//
//  ApiTransaction.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 5/13/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation

class ApiTransaction: NSObject {
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var url: URL?
    var completion: VoidBlock?
    var params: Dictionary<String, String>?
    
    func makeNetworkRequest() {
        guard let parsedUrl = parseParamsWithURL() else {
            return
        }
        let datatask = defaultSession.dataTask(with: parsedUrl, completionHandler: { (data: Data?, resp: URLResponse?, error: Error?) in
            
        })
        datatask.resume()
    }
    
    func parseParamsWithURL() -> URL? {
        var parsedUrl: String
        guard let url = url, let params = params else {
            return nil
        }
        parsedUrl = url.absoluteString
        parsedUrl += "?"
        for (key, value) in params {
            parsedUrl += "\(key)=\(value)"
        }
        if parsedUrl.characters.last == "&" {
            parsedUrl.remove(at: parsedUrl.endIndex)
        }
        return URL(string: parsedUrl)
    }
}
