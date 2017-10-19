//
//  UIView.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 5/13/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

extension UIView {
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set {
            frame.origin.x = newValue - frame.size.width
        }
    }
    
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set {
            frame.origin.y = newValue - frame.size.height
        }
    }

    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
    
    func centerHorizontally() {
        guard let superview = superview else {
            return
        }
        if superview.width > width  {
            let diff = superview.width - width
            left = diff / 2
        }
    }
    
    func centerVertically() {
        guard let superview = superview else {
            return
        }
        if superview.height > height {
            let diff = superview.height - height
            top = diff / 2
        }
    }
    
    static func genericCloseButton(block: () -> ()) -> UIImageView {
        return UIImageView()
    }
}
