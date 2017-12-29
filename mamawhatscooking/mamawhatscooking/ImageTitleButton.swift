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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        imageTitleImageView.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [imageTitleImageView, imageTitleLabel])
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
