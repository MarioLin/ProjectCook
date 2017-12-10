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
    var completion: DataTaskCompletionBlock?
    var params: [String : String]?
    var didSucceed: Bool = false
    
    func makeNetworkRequest() {
        guard let parsedUrl = parseParamsWithURL() else { fatalError("malformed url") }
        print("API get request: " + parsedUrl.absoluteString)
        let datatask = defaultSession.dataTask(with: parsedUrl) { (data, response, error) in
            if error == nil {
                self.didSucceed = true
            }
            guard let data = data, let response = response else { return }
            let dict = self.serializeDataToJson(data: data)
            let savedObjects = self.saveObjectsFromDict(dictionary: dict)
            DispatchQueue.main.async {
                self.completion?(savedObjects, response, error)
            }
        }
        datatask.resume()
    }
    
    func parseParamsWithURL() -> URL? {
        var parsedUrl: String
        guard let url = url, let params = params else { return nil }
        parsedUrl = url.absoluteString
        parsedUrl += "?"
        for (key, value) in params {
            parsedUrl += "\(key)=\(value)&"
        }
        if parsedUrl.last == "&" {
            parsedUrl = parsedUrl.substring(to: parsedUrl.index(before:parsedUrl.endIndex))
        }
        return URL(string: parsedUrl)
    }
    
    func serializeDataToJson(data: Data) -> [String: Any] {
        var json = Dictionary<String, Any>()
        do {
            json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
        } catch let error as NSError {
            print(error)
        }
        return json
    }
    
    func saveObjectsFromDict(dictionary: [String: Any]) -> [Any] {
        // override
        return []
    }
    
}
