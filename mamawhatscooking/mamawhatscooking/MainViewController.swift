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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
