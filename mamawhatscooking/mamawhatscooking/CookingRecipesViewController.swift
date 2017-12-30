//
//  CookingRecipesViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/10/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit
import Shimmer

class CookingRecipesViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var shimmerView: FBShimmeringView!
    @IBOutlet private weak var cookPotImageView: UIImageView!
    @IBOutlet private weak var recipeButton: RoundedBurritoButton!
    
    // MARK: Properties
    var searchParams: [String:String]! // this NEEDS to be injected by a VC
    var searchedRecipes: [YummlySearchModel]?
    private var selectedRecipeModel: RecipeModel?
    private var orbittingImageViews = [UIImageView]()
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let yummlyReq = YummlyApiTransaction()
        yummlyReq.completion = { [weak self] (objects, response, error) in
            if let recipes = objects as? [YummlySearchModel] {
                self?.searchedRecipes = recipes
                self?.handleSearchedRecipes()
            } else {
                // error
            }
        }
        yummlyReq.makeSearchRequest(params: searchParams)
        shimmerView.contentView = infoLabel
        view.addSubview(shimmerView)
        shimmerView.isShimmering = true
        recipeButton.isHidden = true
        setupOrbitImages()
    }
    
    private func handleSearchedRecipes() {
        guard let recipes = searchedRecipes else { return }
        let randomNum = Int(arc4random_uniform(UInt32(recipes.count)))
        let randomRecipe = recipes[randomNum]
        
        guard let recipeId = randomRecipe.recipeId else {
            assertionFailure("no recipe ID found for random recipe")
            return
        }

        let recipeReq = YummlyRecipeDetailTransacation()
        recipeReq.completion = { [weak self] (objects, response, error) in
            if let recipeModel = objects?.first as? RecipeModel {
                // do something with recipe
                self?.selectedRecipeModel = recipeModel
                self?.recipeButton.isHidden = false
                self?.recipeButton.touchUpInsideBlock = { [weak self] ctl in
                    self?.performSegue(withIdentifier: recipeSegue, sender: self)
                }
            }
        }
        recipeReq.makeRecipeRequest(recipeId: recipeId)
    }

    // MARK: IBActions
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? RecipeViewController {
            dest.recipeModel = selectedRecipeModel
        }
    }
    
    private func setupOrbitImages() {
        
    }
    
    private func orbitAnimation(rect: CGRect) -> CAKeyframeAnimation {
        let orbit = CAKeyframeAnimation()
        orbit.keyPath = "position";
        orbit.path = CGPath(ellipseIn: rect, transform: nil)
        orbit.duration = 4;
        orbit.isAdditive = true;
        orbit.repeatCount = Float.greatestFiniteMagnitude;
        orbit.calculationMode = kCAAnimationPaced;
        orbit.rotationMode = kCAAnimationRotateAuto;
        return orbit
    }
    
}
