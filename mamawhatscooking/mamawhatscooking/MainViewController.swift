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
    
    // MARK: IBOutlets
    @IBOutlet weak var breakfastBtn: ImageTitleButton!
    @IBOutlet weak var lunchBtn: ImageTitleButton!
    @IBOutlet weak var dinnerBtn: ImageTitleButton!
    @IBOutlet weak var dessertBtn: ImageTitleButton!
    @IBOutlet weak var appetizerBtn: ImageTitleButton!
    @IBOutlet weak var drinkBtn: ImageTitleButton!
    
    // MARK: Properties
    var searchParams:[String:String]?
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Private
    private func setupButtons() {
        breakfastBtn.imageTitleImageView.image = UIImage(named: "brunch")?.imageWithColor(color: .yummyOrange)
        breakfastBtn.imageTitleLabel.textColor = .yummyOrange
        breakfastBtn.imageTitleLabel.text = "Breakfast/Brunch"
        
        lunchBtn.imageTitleImageView.image = UIImage(named: "lunch")?.imageWithColor(color: .white)
        lunchBtn.imageTitleLabel.textColor = .white
        lunchBtn.imageTitleLabel.text = "Lunch"

        dinnerBtn.imageTitleImageView.image = UIImage(named: "dinner")?.imageWithColor(color: .white)
        dinnerBtn.imageTitleLabel.textColor = .white
        dinnerBtn.imageTitleLabel.text = "Dinner"

        dessertBtn.imageTitleImageView.image = UIImage(named: "dessert")?.imageWithColor(color: .yummyOrange)
        dessertBtn.imageTitleLabel.textColor = .yummyOrange
        dessertBtn.imageTitleLabel.text = "Dessert"

        appetizerBtn.imageTitleImageView.image = UIImage(named: "appetizer")?.imageWithColor(color: .yummyOrange)
        appetizerBtn.imageTitleLabel.textColor = .yummyOrange
        appetizerBtn.imageTitleLabel.text = "Appetizer"

        drinkBtn.imageTitleImageView.image = UIImage(named: "drink")?.imageWithColor(color: .white)
        drinkBtn.imageTitleLabel.textColor = .white
        drinkBtn.imageTitleLabel.text = "Drink"


    }
    
    // MARK: Navigation
    func segueToSearchScreen() {
        performSegue(withIdentifier: searchSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CookingRecipesViewController {
            dest.searchParams = searchParams
        }
    }
}
