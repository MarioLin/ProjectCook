//
//  TasteViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/9/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

fileprivate enum TasteType {
    case spicy
    case sweet
    case savory
}

class TasteViewController: UIViewController {
    var params = [String:String]()
    
    // MARK: Interface Builder
    @IBAction func spicyButtonTapped(_ sender: Any) {
        self.handleTastePressed(sender, .spicy)
    }

    @IBAction func sweetButtonTapped(_ sender: Any) {
        self.handleTastePressed(sender, .spicy)
    }
    
    @IBAction func savoryButtonTapped(_ sender: Any) {
        self.handleTastePressed(sender, .spicy)
    }
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton;

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

    
    private func handleTastePressed(_ sender: Any, _ taste: TasteType) {
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
        performSegue(withIdentifier: searchSegue, sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CookingRecipesViewController {
            dest.searchParams = params
        }
    }
    

}
