//
//  LevelView.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 6/25/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

class LevelView: UIView {
    static let paddingBetween: CGFloat = 8
    private static let sizeOfSelection: CGSize = CGSize(width: 20, height: 20)

    private var numberOfLevels: Int
    
    init(numberOfLevels: Int) {
        self.numberOfLevels = numberOfLevels
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Int) {
        numberOfLevels = model
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let width = CGFloat(numberOfLevels) * (LevelView.paddingBetween + LevelView.sizeOfSelection.width)
        return CGSize(width: width, height: LevelView.sizeOfSelection.height)
    }
}
