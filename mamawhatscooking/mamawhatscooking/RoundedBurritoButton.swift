//
//  RoundedBurritoButton.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 5/13/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit

class RoundedBurritoButton: UIButton {
    var touchUpInsideBlock: TouchBlock?
    var savedBackgroundColor: UIColor?
    var savedBorderColor: UIColor?
    
    override var isHighlighted: Bool {
        didSet {
            if let _ = savedBackgroundColor, let _ = savedBorderColor {
                let mainColor = isHighlighted ? savedBackgroundColor : savedBorderColor
                let outerColor = isHighlighted ? savedBorderColor : savedBackgroundColor

                backgroundColor = outerColor
                layer.borderColor = mainColor?.cgColor
                setTitleColor(mainColor, for: .normal)
            }
        }
    }
    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + 20
        return CGSize(width: width, height: superContentSize.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 4.5
        addTarget(self, action: #selector(touchedUpInside), for: .touchUpInside)
        savedBackgroundColor = backgroundColor
        savedBorderColor = currentTitleColor
    }
    
    func touchedUpInside() {
        guard let touchBlock = touchUpInsideBlock else {
            return
        }
        touchBlock(self)
    }
}
