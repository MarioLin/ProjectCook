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
    
    override init() {
        super.init()
    }

    override func viewDidLoad() {
        view.backgroundColor = .orange
        view.addSubview(mainButton)
        view.addSubview(chefHatView)
        mainButton.touchUpInsideBlock = { [weak self] (sender: Any) in
            guard let strongSelf = self else { return }
            let recipeTastes = RecipeTastes()
            let tasteSurveyVC = TastesSurveyViewController(surveryOption: globalSurveryOrder[0], recipeTastes: recipeTastes)
            let navVC = BaseNavViewController(rootViewController: tasteSurveyVC)
            strongSelf.present(navVC, animated: true, completion: nil)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
