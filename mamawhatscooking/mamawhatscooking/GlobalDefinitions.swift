//
//  GlobalConstants.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 5/13/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit

typealias VoidBlock = () -> ()
typealias TouchBlock = (_ sender: Any) -> ()
typealias DataTaskCompletionBlock = (_ objects: [Any]?, _ response: URLResponse?, _ error: Error?) -> ()

extension UIColor {
    static var yummyOrange = UIColor(red: 255.0/255.0, green: 176.0/255.0, blue: 9.0/255.0, alpha: 1)
}


// derived from https://stackoverflow.com/questions/31803157/how-to-color-a-uiimage-in-swift
extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage? {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if let img = UIGraphicsGetImageFromCurrentImageContext() {
            image = img
        }
        UIGraphicsEndImageContext()
        return image
    }
}
