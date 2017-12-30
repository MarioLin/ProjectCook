//
//  CuisineSelectionViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/29/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

private enum Constants {
    static let stackViewSpacing: CGFloat = 0
    static let stackViewLeadingSpacing: CGFloat = 20
}

class CuisineSelectionViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var exitButton: UIButton!
    
    private var stackView: UIStackView!
    private var cuisineButtons: [RoundedBurritoButton]! // gets initialized right after super
    
    var didSelectCuisineClosure: ((_ type: CuisineType) -> ())?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        var buttons = [RoundedBurritoButton]()
        for cuisineType in CuisineType.allValues {
            let displayName = CuisineType.typeToDisplayParamString(cuisineType).displayName
            buttons.append(RoundedBurritoButton.defaultSelectionButton(displayName) { [weak self] ctl in
                self?.cuisineTypeSelected(type: cuisineType)
            })
        }
        cuisineButtons = buttons
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = UIImage(named: "exit")?.imageWithColor(color: .white) {
            exitButton.setImage(image, for: .normal)
        }
        stackView = UIStackView(arrangedSubviews: cuisineButtons)
        
        for button in cuisineButtons {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1).isActive = true
        }
        
        stackView.spacing = Constants.stackViewSpacing
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        scrollView.addSubview(stackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // constrain the stackview's top/bottom/left/right anchors to the
        // scrollview to get the contentSize to size automatically
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                         multiplier: 1).isActive = true

    }
    
    private func cuisineTypeSelected(type: CuisineType) {
        didSelectCuisineClosure?(type)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: IBAction
    @IBAction func exitButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
