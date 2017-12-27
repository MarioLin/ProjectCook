//
//  CuisineViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/27/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit

class CuisineViewController: SelectionViewController {
    override func selectableButtons() -> [RoundedBurritoButton] {
        return [RoundedBurritoButton.defaultSelectionButton("Asian") {_ in
            
            }]
    }
    
    override func navTitle() -> String {
        return "Cuisine"
    }
}
