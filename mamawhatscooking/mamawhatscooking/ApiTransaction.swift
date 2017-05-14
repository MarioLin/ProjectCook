//
//  ApiTransaction.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 5/13/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
typealias VoidBlock = () -> ()

class ApiTransaction: NSObject {
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var url: URL?
    var completion: VoidBlock?
    var params: Dictionary<String, String>?
    
    override init() {
        super.init()
    }
    func makeNetworkRequest() {
        
    }
}
