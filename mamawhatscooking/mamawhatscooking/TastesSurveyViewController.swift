//
//  TastesSurveyViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 6/14/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit

// spicy, sweet, savory, allowedCuisine[], allowedDiet[], allowedAllergy[], allowedCourse
class TastesSurveyViewController: BaseViewController {
    init(surveryOption: TasteSurveryOption, recipeTastes: RecipeTastes) {
        super.init()
    }

    //TODO: called at end of flow
    func makeTransaction() {
        let transaction = YummlyApiTransaction()
        transaction.completion = { (_ objects: [Any]?, _ response: URLResponse?, _ error: Error?) -> () in
            guard let objects = objects else { return }
            let randomNumber = arc4random_uniform(UInt32(objects.count))
            guard let recipeToGet = objects[Int(randomNumber)] as? YummlySearchModel else { return }
            
            // get the selected recipe details
            let recipeTransaction = YummlyRecipeDetailTransacation()
            recipeTransaction.completion = { [weak self] (_ objects: [Any]?, _ response: URLResponse?, _ error: Error?) -> () in
                guard let strongSelf = self else { return }
                let recipeVC = RecipeViewController()
                let navVC = BaseNavViewController(rootViewController: recipeVC)
                strongSelf.present(navVC, animated: true, completion: nil)
            }
            recipeTransaction.makeRecipeRequest(recipeId: recipeToGet.recipeId!)
        }
        transaction.makeSearchRequest(params: ["q" : "onion%20soup"])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
