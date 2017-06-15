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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(touchedUpInside), for: .touchUpInside)
        layer.cornerRadius = 4.5
    }
    
    required convenience init(title: String, backgroundColor: UIColor = .orange, borderColor: UIColor = .white) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        savedBackgroundColor = backgroundColor
        savedBorderColor = borderColor
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 2
        setTitle(title, for: .normal)
        setTitleColor(borderColor, for: .normal)
    }
    
    func touchedUpInside() {
        guard let touchBlock = touchUpInsideBlock else {
            return
        }
        touchBlock(self)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
