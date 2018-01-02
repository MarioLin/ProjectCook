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
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var shimmerView: FBShimmeringView!
    @IBOutlet weak var cuisineImageView: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackViewShimmer: FBShimmeringView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shimmerView.contentView = infoLabel
        shimmerView.isShimmering = true
        
        stackViewShimmer.contentView = containerView
        stackViewShimmer.isShimmering = true
    }
}
