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
    private static let heightForIcon: Float = 45
    
    var levelSelectedClsre: ((Int) -> ())?
    private let tasteIconView = UIImageView()
    private let questionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tasteIconView)
        addSubview(questionLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    static func height(model: TasteLevelModel) -> Float {
        return 30
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
