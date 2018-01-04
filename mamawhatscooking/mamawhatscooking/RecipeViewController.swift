//
//  RecipeViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/10/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

fileprivate enum Constants {
    static let timeToWait: TimeInterval = 1.5
}

class RecipeViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var timingLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var exitButton: UIButton!
    @IBOutlet private weak var timingImageView: UIImageView!
    
    // MARK: Properties
    fileprivate var cellModels = [Any]()
    var recipeModel: RecipeModel!
    
    var searchParams: [String: String]! // NEEDS TO BE INJECTED, will trap in viewDidLoad otherwise
    var recipeType: RecipeCourseType = .lunch // default lunch, this should be injected & changed by source VC
    
    private var loadingView: RecipeLoadingView! // guards in viewDidLoad
    private var requestTime: Date?
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        precondition(searchParams != nil)
        
        if let exitImage = UIImage(named: "exit")?.imageWithColor(color: .yummyOrange) {
            exitButton.setImage(exitImage, for: .normal)
        }
        
        guard let loading = Bundle.main.loadNibNamed("RecipeLoadingView", owner: self, options: nil)?.first as? RecipeLoadingView else {
            fatalError("failed to load loading view nib")
        }
        
        loadingView = loading
        loadingView.cuisineImageView.image = image(courseType: recipeType)
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        timingLabel.text = ""
        timingLabel.isHidden = true
        timingImageView.isHidden = true
        
        setupTableView()
        getRecipeThenLoadData()
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
                                           cuisine: nil,
                                           rating: recipeModel.rating)
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
        timingLabel.text = recipeModel.totalTimeString ?? "N/A"
        cellModels = models
    }

    private func image(courseType: RecipeCourseType) -> UIImage? {
        switch courseType {
        case .breakfast: return UIImage(named: imageStrBreakfast)
        case .lunch: return UIImage(named: imageStrLunch)
        case .dinner: return UIImage(named: imageStrDinner)
        case .dessert: return UIImage(named: imageStrDessert)
        case .drink: return UIImage(named: imageStrDrink)
        case .appetizer: return UIImage(named: imageStrAppetizer)
        }
    }
    
    // MARK: API
    private func getRecipeThenLoadData() {
        let yummlyReq = YummlyApiTransaction()
        
        requestTime = Date()
        yummlyReq.completion = { [weak self] (objects, response, error) in
            if let recipes = objects as? [YummlySearchModel] {
                self?.handle(searchedRecipes: recipes)
            } else {
                // error
            }
        }
        yummlyReq.makeSearchRequest(params: searchParams)
        
    }
    private func handle(searchedRecipes: [YummlySearchModel]) {
        let randomNum = Int(arc4random_uniform(UInt32(searchedRecipes.count)))
        let randomRecipe = searchedRecipes[randomNum]
        
        guard let recipeId = randomRecipe.recipeId else {
            assertionFailure("no recipe ID found for random recipe")
            return
        }
        
        let recipeReq = YummlyRecipeDetailTransacation()
        recipeReq.completion = { [weak self] (objects, response, error) in
            var timeForRequest: TimeInterval = 0
            if let startDate = self?.requestTime {
                timeForRequest = Date().timeIntervalSince(startDate)
            }
            
            let timeRemainingToWait = (timeForRequest > 0 && timeForRequest < 10) ? Constants.timeToWait - timeForRequest : 0
            
            let delayTime = DispatchTime.now() + timeRemainingToWait
            DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
                if let recipeModel = objects?.first as? RecipeModel {
                    self?.recipeModel = recipeModel
                    self?.setupModels()
                    self?.tableView.reloadData()
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        self?.loadingView.isHidden = true
                        self?.timingImageView.isHidden = false
                        self?.timingLabel.isHidden = false
                    })
                }
            })
        }
        recipeReq.makeRecipeRequest(recipeId: recipeId)
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
