//
//  MainViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/1/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit

enum RecipeCourseType {
    case breakfast
    case lunch
    case dinner
    case dessert
    case appetizer
    case drink
}

class MainViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var breakfastBtn: ImageTitleButton!
    @IBOutlet private weak var lunchBtn: ImageTitleButton!
    @IBOutlet private weak var dinnerBtn: ImageTitleButton!
    @IBOutlet private weak var dessertBtn: ImageTitleButton!
    @IBOutlet private weak var appetizerBtn: ImageTitleButton!
    @IBOutlet private weak var drinkBtn: ImageTitleButton!
    
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
        breakfastBtn.setTouchBlock { [unowned self] (ctl) in
            self.tappedRecipeButton(.breakfast)
        }
        
        lunchBtn.imageTitleImageView.image = UIImage(named: "lunch")?.imageWithColor(color: .white)
        lunchBtn.imageTitleLabel.textColor = .white
        lunchBtn.imageTitleLabel.text = "Lunch"
        lunchBtn.setTouchBlock { [unowned self] (ctl) in
            self.tappedRecipeButton(.lunch)
        }
        
        dinnerBtn.imageTitleImageView.image = UIImage(named: "dinner")?.imageWithColor(color: .white)
        dinnerBtn.imageTitleLabel.textColor = .white
        dinnerBtn.imageTitleLabel.text = "Dinner"
        dinnerBtn.setTouchBlock { [unowned self] (ctl) in
            self.tappedRecipeButton(.dinner)
        }
        
        dessertBtn.imageTitleImageView.image = UIImage(named: "dessert")?.imageWithColor(color: .yummyOrange)
        dessertBtn.imageTitleLabel.textColor = .yummyOrange
        dessertBtn.imageTitleLabel.text = "Dessert"
        dessertBtn.setTouchBlock { [unowned self] (ctl) in
            self.tappedRecipeButton(.dessert)
        }
        
        appetizerBtn.imageTitleImageView.image = UIImage(named: "appetizer")?.imageWithColor(color: .yummyOrange)
        appetizerBtn.imageTitleLabel.textColor = .yummyOrange
        appetizerBtn.imageTitleLabel.text = "Appetizer"
        appetizerBtn.setTouchBlock { [unowned self] (ctl) in
            self.tappedRecipeButton(.appetizer)
        }
        
        drinkBtn.imageTitleImageView.image = UIImage(named: "drink")?.imageWithColor(color: .white)
        drinkBtn.imageTitleLabel.textColor = .white
        drinkBtn.imageTitleLabel.text = "Drink"
        drinkBtn.setTouchBlock { [unowned self] (ctl) in
            self.tappedRecipeButton(.drink)
        }
    }
    
    private func tappedRecipeButton(_ type: RecipeCourseType) {
        searchParams = YummlyApiTransaction.defaultSearchParams(type)
        performSegue(withIdentifier: searchSegue, sender: self)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? RecipeViewController {
            dest.searchParams = searchParams
        }
        else if let dest = segue.destination as? CuisineSelectionViewController {
            dest.didSelectCuisineClosure = { cuisineType in
                
            }
        }
    }
}
