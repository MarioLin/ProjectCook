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
    case tastePreference
    case allowedCuisine
    case allowedDiet
    case allowedAllergy
    case allowedCourse
    
    static func globalSurveryOrder() -> [TasteSurveryOption] {
        return [.allowedCourse, .tastePreference, .allowedCuisine, .allowedDiet,.allowedAllergy]
    }
}

// allowedCourse[], [spicy, sweet, savory,], allowedCuisine[], allowedDiet[], allowedAllergy[]
class TastesSurveyViewController: ScrollablePageViewController {
    private let recipeTasteData = RecipeTasteData()
    private let currentOptionIndex: Int = 0
    private let option: TasteSurveryOption
    let closeButton: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override init() {
        self.option = TasteSurveryOption.globalSurveryOrder().first!
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
//            recipeTransaction.completion = { [weak self] (_ objects: [Any]?, _ response: URLResponse?, _ error: Error?) -> () in
//                guard let strongSelf = self else { return }
//                
//            }
            recipeTransaction.makeRecipeRequest(recipeId: recipeToGet.recipeId!)
        }
        transaction.makeSearchRequest(params: ["q" : "onion%20soup"])
    }
    
    override func buildPages() -> [UIView]? {
        var pages = [UIView]()
        let containerView = UIView(frame: self.view.bounds)
        
        let selectionVC = SelectionViewController(selections: spoofData())
        containerView.addSubview(selectionVC.view)
        
        pages.append(containerView)
        return pages
    }
    
    
    func spoofData() -> [SelectionEntity] {
        var entitites = [SelectionEntity]()
        for i in 1...10 {
            let entity = SelectionEntity(displayName: "testest\(i)", machineName: "hi", type: "hi")
            entitites.append(entity)
        }
        return entitites
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
