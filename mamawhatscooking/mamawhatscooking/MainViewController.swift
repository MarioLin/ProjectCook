//
//  MainViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/1/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var startButton: RoundedBurritoButton!
    
    var searchParams:[String:String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func segueToSearchScreen() {
        performSegue(withIdentifier: searchSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CookingRecipesViewController {
            dest.searchParams = searchParams
        }
    }
}
