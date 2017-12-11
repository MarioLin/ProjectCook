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
    var searchParams: [String:String]! // this NEEDS to be injected by a VC
    var searchedRecipes: [YummlySearchModel]?
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var shimmerView: FBShimmeringView!
    
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
            }
        }
        recipeReq.makeRecipeRequest(recipeId: recipeId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
