//
//  RecipeViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/10/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate var cellModels = [Any]()
    
    var recipeModel: RecipeModel! // NEEDS TO BE INJECTED
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        setupModels()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        // register reuse
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "RecipeTableViewCell")
    }
    
    private func setupModels() {
        var models = [Any]()
        
        models.append(RecipeCellModel(imageString: recipeModel.largeImageUrl ?? "", title: recipeModel.recipeName))
        
        cellModels = models
    }
}

extension RecipeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension RecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > cellModels.count { // something went wrong
            fatalError("cellModels not sync'd with number of cells in table view")
        }
        
        let model = cellModels[indexPath.row]
        switch model.self {
        case is RecipeCellModel:
            let recipeCell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
            recipeCell.configure(model: model as! RecipeCellModel)
            return recipeCell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
}
