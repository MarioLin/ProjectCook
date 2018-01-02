//
//  RecipeLoadingView.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 1/1/18.
//  Copyright © 2018 Mario Lin. All rights reserved.
//

import UIKit
import Shimmer

class RecipeLoadingView: UIView {
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var shimmerView: FBShimmeringView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shimmerView.contentView = infoLabel
        shimmerView.isShimmering = true
    }
}
