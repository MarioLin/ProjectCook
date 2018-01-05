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
    @IBOutlet private weak var shimmerView: FBShimmeringView!
    @IBOutlet weak var cuisineImageView: UIImageView!
    
    @IBOutlet weak var vegetarianHintView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackViewShimmer: FBShimmeringView!
    
    @IBOutlet weak var poweredByLabel: UILabel!
    @IBOutlet weak var poweredByImageView: UIImageView!
    @IBOutlet weak var attributionStack: UIStackView!
    
    var tappedAttributionBlock: VoidBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shimmerView.contentView = infoLabel
        shimmerView.isShimmering = true
        
        attributionStack.isHidden = true
        stackViewShimmer.contentView = containerView
        stackViewShimmer.isShimmering = true
    }
    
    func showAttribution(text: String, logoURL: String?, tappedBlock: @escaping VoidBlock) {
        poweredByLabel.text = text
        if let logoURL = logoURL {
            poweredByImageView.downloadImage(link: logoURL)
        }
        
        tappedAttributionBlock = tappedBlock
        let labelTapGR = UITapGestureRecognizer(target: self, action: #selector(tappedAttribution))
        let imageViewTapGR = UITapGestureRecognizer(target: self, action: #selector(tappedAttribution))
        poweredByLabel.removeAllGestureRecognizers()
        poweredByImageView.removeAllGestureRecognizers()
        poweredByLabel.addGestureRecognizer(labelTapGR)
        poweredByImageView.addGestureRecognizer(imageViewTapGR)
        
        attributionStack.isHidden = false
    }
    
    @objc private func tappedAttribution() {
        tappedAttributionBlock?()
    }
}
