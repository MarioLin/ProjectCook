//
//  MainViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 5/13/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    let mainButton = RoundedBurritoButton.init(title: "Start")
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(mainButton)

        mainButton.width = view.width - 2 * 25;
        mainButton.height = 44
        mainButton.centerVertically()
        mainButton.centerHorizontally()
        
        mainButton.touchUpInsideBlock = { [weak self] (sender: Any) in
            guard let strongSelf = self else { return }
            strongSelf.makeTransaction()
        }
    }
    
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
                let navVC = UINavigationController(rootViewController: recipeVC)
                strongSelf.present(navVC, animated: true, completion: nil)
            }
            recipeTransaction.makeRecipeRequest(recipeId: recipeToGet.recipeId!)
        }
        transaction.makeSearchRequest(params: ["q" : "onion%20soup"])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
