//
//  MamaViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 6/14/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController : UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .orange
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
