//
//  SelectionViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/27/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit


class SelectionViewController: UIViewController {
    private var stackView: UIStackView!
    
    private lazy var buttons: [RoundedBurritoButton] = {
        return self.selectableButtons()
    }()
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView = UIStackView(arrangedSubviews: buttons)
        stackView.spacing = 25
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    func selectableButtons() -> [RoundedBurritoButton] {
        return [RoundedBurritoButton.defaultSelectionButton("Test") {idx in }]
    }
    
}

extension RoundedBurritoButton {
    static func defaultSelectionButton(_ text: String, _ fontSize: CGFloat = 30, _ selectBlock: @escaping TouchBlock) -> RoundedBurritoButton {
        let button = RoundedBurritoButton(text: text, fontSize: fontSize, backgroundColor: .yummyOrange, titleColor: .white)
        button.touchUpInsideBlock = selectBlock
        return button
    }
}
