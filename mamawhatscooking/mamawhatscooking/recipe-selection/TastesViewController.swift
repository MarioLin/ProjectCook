//
//  TastesViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/27/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit

fileprivate enum TasteType {
    case spicy
    case sweet
    case savory
}

class TastesViewController: SelectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonPressed))
        backButton.tintColor = .orange
        navigationItem.leftBarButtonItem = backButton;
    }
    
    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    private func handleTastePressed(_ sender: Any, _ taste: TasteType) {
        params = startParams
        switch taste {
        case .spicy:
            params[spicyMaxParam] = "1"
            params[spicyMinParam] = "0.8"
        case .sweet:
            params[sweetMaxParam] = "1"
            params[sweetMinParam] = "0.8"
        case .savory:
            params[savoryMaxParam] = "1"
            params[savoryMinParam] = "0.8"
        }
        
//        if let main = presentingViewController as? MainViewController {
//            main.searchParams = params
//            self.dismiss(animated: true) {
//                main.segueToSearchScreen()
//            }
//        }
        
        performSegue(withIdentifier: tasteToCuisineSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CuisineViewController {
            dest.params = params
        }
    }
    
    // MARK: SelecitionViewController overrides
    override func selectableButtons() -> [RoundedBurritoButton] {
        return [RoundedBurritoButton.defaultSelectionButton("I want savory!") { [unowned self] ctl in
                    self.handleTastePressed(ctl, .sweet)
                },
                RoundedBurritoButton.defaultSelectionButton("I have a sweet tooth!") { [unowned self] ctl in
                    self.handleTastePressed(ctl, .savory)
                },
                RoundedBurritoButton.defaultSelectionButton("I like spicy!") { [unowned self] ctl in
                    self.handleTastePressed(ctl, .spicy)
                },]
    }
    
    override func navTitle() -> String {
        return "Tastes"
    }
}
