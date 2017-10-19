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
            let detailVC = SelectionViewController(selections: strongSelf.spoofData())
            strongSelf.present(detailVC, animated: true, completion: nil)
        }
    }
    
    func spoofData() -> [SelectionEntity] {
        var entitites = [SelectionEntity]()
        for i in 1...10 {
            let entity = SelectionEntity(displayName: "testest\(i)", machineName: "hi", type: "hi")
            entitites.append(entity)
        }
        return entitites
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
