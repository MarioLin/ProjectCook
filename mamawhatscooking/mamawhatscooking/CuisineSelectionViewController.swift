//
//  CuisineSelectionViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/29/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

enum CuisineType {
    
}

class CuisineSelectionViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: IBAction
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
