//
//  SelectionViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/27/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit

class SelectionViewController: UIViewController {
    var params = [String:String]()

    var buttons: [RoundedBurritoButton]?
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        title = navTitle()
        buttons = selectableButtons()
    }
    
    // MARK: Subclass overrides
    func selectableButtons() -> [RoundedBurritoButton] {
        fatalError("subclass must override")
    }
    
    func navTitle() -> String {
        fatalError("subclass must override")
    }
}
