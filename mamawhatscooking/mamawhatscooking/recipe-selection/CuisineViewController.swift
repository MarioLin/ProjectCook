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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonPressed))
        backButton.tintColor = .orange
        navigationItem.leftBarButtonItem = backButton;
    }

    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    private func handleCuisineParam(cuisine: String) {
        params["allowedCuisine[]"] = "cuisine^cuisine-\(cuisine)"
        performSegue(withIdentifier: cuisineToCourseSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CourseViewController {
            dest.params = params
        }
    }

    // MARK: SelectionViewController overrides
    override func selectableButtons() -> [RoundedBurritoButton] {
        return [RoundedBurritoButton.defaultSelectionButton("Asian") { [unowned self] _ in
                self.handleCuisineParam(cuisine: "asian")
            },
                RoundedBurritoButton.defaultSelectionButton("Mexican") { [unowned self] _ in
                    self.handleCuisineParam(cuisine: "mexican")
            },
                RoundedBurritoButton.defaultSelectionButton("American") { [unowned self] _ in
                    self.handleCuisineParam(cuisine: "american")
            },
                RoundedBurritoButton.defaultSelectionButton("Indian") { [unowned self] _ in
                    self.handleCuisineParam(cuisine: "indian")
            },
                RoundedBurritoButton.defaultSelectionButton("Southern") { [unowned self] _ in
                    self.handleCuisineParam(cuisine: "southern")
            },
        ]
    }
    
    override func navTitle() -> String {
        return "Cuisine"
    }
}
