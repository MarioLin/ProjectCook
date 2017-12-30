//
//  RecipeViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/10/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var timingLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var exitButton: UIButton!
    
    // MARK: Properties
    fileprivate var cellModels = [Any]()
    var recipeModel: RecipeModel! // NEEDS TO BE INJECTED
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let exitImage = UIImage(named: "exit")?.imageWithColor(color: .yummyOrange) {
            exitButton.setImage(exitImage, for: .normal)
        }
        
        timingLabel.text = recipeModel.totalTimeString ?? "N/A"
        setupTableView()
        
        setupModels()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        tableView.allowsSelection = false
        // register reuse
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "RecipeTableViewCell")
        tableView.register(UINib(nibName: "SourceTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "SourceTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(UINib(nibName: "AttributionTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "AttributionTableViewCell")    }
    
    private func setupModels() {
        var models = [Any]()
        let pictureModel = RecipeCellModel(imageString: recipeModel.largeImageUrl ?? "",
                                           title: recipeModel.recipeName,
                                           servings: recipeModel.yield,
                                           cuisine: nil)
        models.append(pictureModel)
        
        if let source = recipeModel.sourceModel {
            let sourceModel = SourceCellModel(recipeCreator: source.displayName) { ctl in
                print("logg")
            }
            models.append(sourceModel)
        }
        
        if let ingredients = recipeModel.ingredients {
            ingredients.forEach { models.append($0) }
        }
        if let attributionModel = recipeModel.attributionModel {
            models.append(attributionModel)
        }
        
        cellModels = models
    }
    
    // MARK: IBActions
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

// MARK:
extension RecipeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK:
extension RecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > cellModels.count { // something went wrong
            fatalError("cellModels not sync'd with number of cells in table view")
        }
        
        let model = cellModels[indexPath.row]
        
        switch model.self {
            
        case is RecipeCellModel:
            if let recipeCell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as? RecipeTableViewCell,
                let model = model as? RecipeCellModel {
                recipeCell.configure(model: model)
                recipeCell.selectionStyle = .none
                return recipeCell
            }
            
        case is SourceCellModel:
            if let sourceCell = tableView.dequeueReusableCell(withIdentifier: "SourceTableViewCell", for: indexPath) as? SourceTableViewCell,
                let model = model as? SourceCellModel {
                sourceCell.configure(model: model)
                sourceCell.selectionStyle = .none
                return sourceCell
            }
            
        case is String:
            let ingredientLineCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            if let model = model as? String {
                ingredientLineCell.textLabel?.text = model
                return ingredientLineCell
            }
            
        case is AttributionModel:
            if let attributionCell = tableView.dequeueReusableCell(withIdentifier: "AttributionTableViewCell", for: indexPath) as? AttributionTableViewCell,
                let model = model as? AttributionModel {
                attributionCell.configure(model: model)
                return attributionCell
            }
        default:
            assertionFailure("cellModel \(model) not sync'd with cells in table view")
        }
        
        // default cell, should never be hit
        assertionFailure("cellModel \(model)'s cell not properly configured")
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
}
