//
//  ImageTitleView.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/28/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

class ImageTitleButton: UIButton {
    let imageTitleImageView = UIImageView()
    let imageTitleLabel = UILabel()
    private let stackView = UIStackView()
    
    override func setTouchBlock(_ block: @escaping (Any) -> ()) {
        super.setTouchBlock(block)
        imageTitleImageView.isUserInteractionEnabled = true
        imageTitleLabel.isUserInteractionEnabled = true
        imageTitleImageView.gestureRecognizers?.forEach(imageTitleLabel.removeGestureRecognizer)
        imageTitleLabel.gestureRecognizers?.forEach(imageTitleLabel.removeGestureRecognizer)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapBlock))
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapBlock))
        let stackViewGesture = UITapGestureRecognizer(target: self, action: #selector(tapBlock))

        imageTitleImageView.addGestureRecognizer(imageTapGesture)
        imageTitleLabel.addGestureRecognizer(tapGesture)
        stackView.addGestureRecognizer(stackViewGesture)
    }
    
    @objc private func tapBlock() {
        self.block?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        imageTitleImageView.contentMode = .scaleAspectFit
        
        stackView.addArrangedSubview(imageTitleImageView)
        stackView.addArrangedSubview(imageTitleLabel)
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
