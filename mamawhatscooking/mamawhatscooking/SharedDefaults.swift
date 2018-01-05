//
//  SharedDefaults.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 1/4/18.
//  Copyright © 2018 Mario Lin. All rights reserved.
//

import Foundation

let cuisineTypeDefaultsKey = "cuisineTypeDefaultsKey"
let vegetarianCustomizeKey = "vegetarianCustomizeKey"

extension UserDefaults {
    static func setDefaultForVegetarianOption(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: vegetarianCustomizeKey)
    }

    static func getDefaultForVegetarianOption() -> Bool {
        return UserDefaults.standard.bool(forKey: vegetarianCustomizeKey)
    }

    static func setDefaultForCuisine(type: CuisineType) {
        UserDefaults.standard.set(type.rawValue, forKey: cuisineTypeDefaultsKey)
    }

    static func getDefaultForCuisine() -> CuisineType? {
        let cuisineRawValue = UserDefaults.standard.integer(forKey: cuisineTypeDefaultsKey)
        if let cuisineType = CuisineType(rawValue: cuisineRawValue) {
            return cuisineType
        }
        return nil
    }
}
