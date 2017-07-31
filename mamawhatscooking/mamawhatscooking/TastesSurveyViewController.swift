//
//  TastesSurveyViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 6/14/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit

enum TasteSurveryOption {
    case sweet
    case savory
    case spicy
    case allowedCuisine
    case allowedDiet
    case allowedAllergy
    case allowedCourse
    
    static func globalSurveryOrder() -> [TasteSurveryOption] {
        return [.sweet, .savory, .spicy, .allowedCuisine, .allowedDiet, .allowedAllergy, .allowedCourse]
    }
}

// spicy, sweet, savory, allowedCuisine[], allowedDiet[], allowedAllergy[], allowedCourse
class TastesSurveyViewController: BaseViewController {
    let tasteView = TasteLevelPreferenceView(frame: .zero)
    let scrollView = UIScrollView()
    let recipeTasteData: RecipeTasteData
    init(recipeTasteData: RecipeTasteData) {
        self.recipeTasteData = recipeTasteData
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tasteView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tasteView.size = CGSize(width: view.width, height: 300)
        tasteView.backgroundColor = .red
        tasteView.centerVertically()
        tasteView.centerHorizontally()
    }
    
    private func createModelForTasteView() -> TasteLevelPreferenceView {
//        var stringToUse: String, imageToUse: UIImage
//        switch surveyOption {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
    }

    //TODO: called at end of flow
    func fetchRecipes() {
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
