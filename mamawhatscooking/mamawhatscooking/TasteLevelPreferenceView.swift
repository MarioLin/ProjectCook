//
//  TasteLevelPreferenceView.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 6/25/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

enum TasteLevelType {
    case range
    case choice
}

struct TasteLevelModel {
    var tasteIconImage: UIImage?
    let questionText: String
    var choices: [String]?
}

class TasteLevelPreferenceView: UIView {
    private static let sizeForIcon: CGSize = CGSize(width: 40, height: 40)
    
    var levelSelectedClosure: ((Int) -> ())?
    private let tasteIconView = UIImageView()
    private let questionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let levelView = LevelView(numberOfLevels: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tasteIconView)
        addSubview(questionLabel)
        addSubview(levelView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tasteIconView.size = TasteLevelPreferenceView.sizeForIcon
        tasteIconView.top = top
        tasteIconView.centerHorizontally()
        questionLabel.sizeToFit()
        questionLabel.top = tasteIconView.bottom + 20
        questionLabel.centerHorizontally()
        levelView.sizeToFit()
        levelView.top = questionLabel.bottom + 20
    }
    
    func configure(model: TasteLevelModel) {
        
    }
    
    static func height(model: TasteLevelModel) -> Float {
        return 30
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
