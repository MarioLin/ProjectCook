//
//  SelectionEntity.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 10/19/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation

class SelectionEntity {
    let displayName: String
    let machineName: String
    let type: String
    let isChecked: Bool
    init(displayName: String, machineName: String, type: String, isChecked: Bool = false) {
        self.displayName = displayName
        self.machineName = machineName
        self.type = type
        self.isChecked = isChecked
    }
}
