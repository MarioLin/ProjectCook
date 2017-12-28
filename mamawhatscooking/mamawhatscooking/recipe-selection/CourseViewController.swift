//
//  CourseViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/28/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

class CourseViewController: SelectionViewController {

    override func selectableButtons() -> [RoundedBurritoButton] {
        return [RoundedBurritoButton.defaultSelectionButton("Breakfast & Brunch") { [unowned self] _ in
                    self.handleCourseParam(course: "Breakfast and Brunch")
            },
                RoundedBurritoButton.defaultSelectionButton("Lunch or Dinner") { [unowned self] _ in
                    self.handleCourseParam(course: "Main Dishes")
            },
                RoundedBurritoButton.defaultSelectionButton("Dessert") { [unowned self] _ in
                    self.handleCourseParam(course: "Desserts")
            },
                RoundedBurritoButton.defaultSelectionButton("Beverages") { [unowned self] _ in
                    self.handleCourseParam(course: "Beverages")
            },
        ]
    }
    
    private func handleCourseParam(course: String) {
        params["allowedCourse[]"] = "course^course-\(course)"
        
        if let main = presentingViewController as? MainViewController {
            main.searchParams = params
            self.dismiss(animated: true) {
                main.segueToSearchScreen()
            }
        }

    }
    
    override func navTitle() -> String {
        return "Course"
    }
}
