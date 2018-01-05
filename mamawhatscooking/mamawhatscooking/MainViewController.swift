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
    @IBOutlet private weak var cuisineTypeButton: RoundedBurritoButton!
    
    @IBOutlet private weak var settingsButton: UIImageView!
    
    // MARK: Properties
    private var searchParams: [String:String]?
    private var recipeType: RecipeCourseType = .lunch
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupCuisineTypeButton()
        if let settingsImage = UIImage(named: imageStrSettings)?.imageWithColor(color: .yummyOrange) {
            settingsButton.image = settingsImage
            settingsButton.isUserInteractionEnabled = true
            settingsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedSettings)))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Private
    private func setupButtons() {
        breakfastBtn.imageTitleImageView.image = UIImage(named: imageStrBreakfast)?.imageWithColor(color: .yummyOrange)
        breakfastBtn.imageTitleLabel.textColor = .yummyOrange
        breakfastBtn.imageTitleLabel.text = "Breakfast/Brunch"
        breakfastBtn.setTouchBlock { [unowned self] (ctl) in
            self.tappedRecipeButton(.breakfast)
        }
        
        lunchBtn.imageTitleImageView.image = UIImage(named: imageStrLunch)?.imageWithColor(color: .white)
        lunchBtn.imageTitleLabel.textColor = .white
        lunchBtn.imageTitleLabel.text = "Lunch"
        lunchBtn.setTouchBlock { [unowned self] (ctl) in
            self.tappedRecipeButton(.lunch)
        }
        
        dinnerBtn.imageTitleImageView.image = UIImage(named: imageStrDinner)?.imageWithColor(color: .white)
        dinnerBtn.imageTitleLabel.textColor = .white
        dinnerBtn.imageTitleLabel.text = "Dinner"
        dinnerBtn.setTouchBlock { [unowned self] (ctl) in
            self.tappedRecipeButton(.dinner)
        }
        
        dessertBtn.imageTitleImageView.image = UIImage(named: imageStrDessert)?.imageWithColor(color: .yummyOrange)
        dessertBtn.imageTitleLabel.textColor = .yummyOrange
        dessertBtn.imageTitleLabel.text = "Dessert"
        dessertBtn.setTouchBlock { [unowned self] (ctl) in
            self.tappedRecipeButton(.dessert)
        }
        
        appetizerBtn.imageTitleImageView.image = UIImage(named: imageStrAppetizer)?.imageWithColor(color: .yummyOrange)
        appetizerBtn.imageTitleLabel.textColor = .yummyOrange
        appetizerBtn.imageTitleLabel.text = "Appetizer"
        appetizerBtn.setTouchBlock { [unowned self] (ctl) in
            self.tappedRecipeButton(.appetizer)
        }
        
        drinkBtn.imageTitleImageView.image = UIImage(named: imageStrDrink)?.imageWithColor(color: .white)
        drinkBtn.imageTitleLabel.textColor = .white
        drinkBtn.imageTitleLabel.text = "Drink"
        drinkBtn.setTouchBlock { [unowned self] (ctl) in
            self.tappedRecipeButton(.drink)
        }
    }
    
    private func setupCuisineTypeButton() {
        if let cuisineType = UserDefaults.getDefaultForCuisine() {
            cuisineTypeButton.setTitle("Cuisine: \(CuisineType.typeToDisplayParamString(cuisineType).displayName)",
                for: .normal)
        }
    }
    
    private func tappedRecipeButton(_ type: RecipeCourseType) {
        var params = YummlyApiTransaction.defaultSearchParams(type)
        recipeType = type
        if let cuisineType = UserDefaults.getDefaultForCuisine() {
            let cuisineKVPair = cuisineKeyValuePair(cuisineType)
            params[cuisineKVPair.key] = cuisineKVPair.value
        }
        if UserDefaults.getDefaultForVegetarianOption() {
            params[vegetarianKeyValuePair().key] = vegetarianKeyValuePair().value
        }
        searchParams = params
        performSegue(withIdentifier: searchSegue, sender: self)
    }
    
    @objc private func tappedSettings() {
        performSegue(withIdentifier: mainToSettingsSegue, sender: self)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? RecipeViewController {
            dest.searchParams = searchParams
            dest.recipeType = recipeType
        }
        else if let dest = segue.destination as? CuisineSelectionViewController {
            dest.didSelectCuisineClosure = { cuisineType in
                UserDefaults.setDefaultForCuisine(type: cuisineType)
                self.setupCuisineTypeButton()
            }
        }
    }
}
