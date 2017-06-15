//
//  MainViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 5/13/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: BaseViewController {
    let mainButton = RoundedBurritoButton(title: "Cook up a recipe!")
    let chefHatView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: kImageChefHat)
        return imageView
    }()
    
    required init() {
        super.init()
    }

    override func viewDidLoad() {
        view.backgroundColor = .orange
        view.addSubview(mainButton)
        view.addSubview(chefHatView)
        mainButton.touchUpInsideBlock = { [weak self] (sender: Any) in
            guard let strongSelf = self else { return }
            strongSelf.makeTransaction()
        }
    }
    
    override func viewDidLayoutSubviews() {
        mainButton.width = view.width - 2 * 25;
        mainButton.height = 44
        mainButton.centerVertically()
        mainButton.centerHorizontally()
        chefHatView.bottom = mainButton.top - 45
        chefHatView.frame.size = CGSize(width: 100, height: 100)
        chefHatView.centerHorizontally()

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
