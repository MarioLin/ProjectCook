//
//  MainViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 5/13/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    let mainButton = RoundedBurritoButton.init(title: "Start")
    var transaction = YummlyApiTransaction.init()
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(mainButton)

        mainButton.width = view.width - 2 * 25;
        mainButton.height = 44
        mainButton.centerVertically()
        mainButton.centerHorizontally()
        
        transaction.completion = { (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> () in
            guard let data = data, let response = response else {
                    return
            }
            print (data)
            print (response)
        }
        mainButton.touchUpInsideBlock = { (sender: Any) in
            self.transaction.makeSearchRequest(params: ["q" : "onion%20soup"])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
