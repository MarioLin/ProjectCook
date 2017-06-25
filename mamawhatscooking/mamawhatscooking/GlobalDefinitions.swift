//
//  GlobalConstants.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 5/13/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation

enum TasteSurveryOption {
    case sweet
    case savory
    case spicy
    case allowedCuisine
    case allowedDiet
    case allowedAllergy
    case allowedCourse
}

typealias VoidBlock = () -> ()
typealias TouchBlock = (_ sender: Any) -> ()
typealias DataTaskCompletionBlock = (_ objects: [Any]?, _ response: URLResponse?, _ error: Error?) -> ()

let globalSurveryOrder: [TasteSurveryOption] = [.sweet, .savory, .spicy, .allowedCuisine, .allowedDiet, .allowedAllergy, .allowedCourse]
