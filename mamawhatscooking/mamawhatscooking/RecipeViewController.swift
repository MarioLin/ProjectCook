//
//  RecipeViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/10/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit
import SafariServices

fileprivate enum Constants {
    static let timeToWait: TimeInterval = 3.5
}

class RecipeViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var exitButton: UIButton!
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    // MARK: Properties
    fileprivate var cellModels = [Any]()
    var recipeModel: RecipeModel!
    
    var searchParams: [String: String]! // NEEDS TO BE INJECTED, will trap in viewDidLoad otherwise
    var recipeType: RecipeCourseType = .lunch // default lunch, this should be injected & changed by source VC
    var isVegetarianMode: Bool = UserDefaults.getDefaultForVegetarianOption()
    
    private var loadingView: RecipeLoadingView! // guards in viewDidLoad
    private var requestTime: Date?
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        precondition(searchParams != nil)
        
        exitButton.setImage(#imageLiteral(resourceName: "exit").imageWithColor(color: .yummyOrange), for: .normal)
        
        refreshButton.setImage(#imageLiteral(resourceName: "refresh").imageWithColor(color: .yummyOrange), for: .normal)
        
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
        loadingView.vegetarianHintView.isHidden = !isVegetarianMode

        refreshButton.isHidden = true
        recipeNameLabel.alpha = 0
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
            let sourceModel = SourceCellModel(recipeCreator: source.displayName, totalTimeString: recipeModel.totalTimeString ?? "No time information") { [weak self] ctl in
                if let wellformedUrl = source.recipeUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                    let url = URL(string: wellformedUrl) {
                    let safariVC = SFSafariViewController(url: url)
                    self?.present(safariVC, animated: true, completion: nil)
                }
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
        yummlyReq.completion = { [weak self, weak yummlyReq] (objects, response, error) in
            if let recipes = objects as? [YummlySearchModel], recipes.count > 0, error == nil {
                if let attribution = yummlyReq?.searchAttribution {
                    self?.loadingView.showAttribution(text: attribution.text, logoURL: attribution.logo) { [weak self] in
                        if let wellformedUrl = attribution.urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                            let url = URL(string: wellformedUrl) {
                            let safariVC = SFSafariViewController(url: url)
                            self?.present(safariVC, animated: true, completion: nil)
                        }

                    }
                }
                self?.handle(searchedRecipes: recipes)
            } else {
                // error
                self?.handleError(emptyResult: error == nil)
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
                    self?.recipeNameLabel.text = recipeModel.recipeName
                    self?.setupModels()
                    self?.tableView.reloadData()
                    self?.scrollToFirstRow()
                    UIView.animate(withDuration: 0.5, animations: {
                        self?.loadingView.isHidden = true
                        self?.refreshButton.isHidden = false
                    })
                }
            })
        }
        recipeReq.makeRecipeRequest(recipeId: recipeId)
    }
    
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    private func handleError(emptyResult: Bool = false) {
        let errorStr = emptyResult ? "There appeared to be no recipes with this criteria, try searching with a different course and/or cuisine." 
                                    : "Oh no! There was an error getting the recipe, tap the refresh button on the top right to try again."
        loadingView.infoLabel.text = errorStr
        loadingView.infoLabel.font = UIFont(name: "Helvetica Neue", size: 14)
        refreshButton.isHidden = false
    }
    
    // MARK: IBActions
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func refreshTapped(_ sender: Any) {
        loadingView.isHidden = false
        refreshButton.isHidden = true

        // reset loadingView in case of error state
        loadingView.infoLabel.text = "Cooking up a recipe..."
        loadingView.infoLabel.font = UIFont(name: "Helvetica Neue", size: 28)
        
        getRecipeThenLoadData()
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
                ingredientLineCell.textLabel?.numberOfLines = 0
                ingredientLineCell.textLabel?.text = model
                return ingredientLineCell
            }
            
        case is AttributionModel:
            if let attributionCell = tableView.dequeueReusableCell(withIdentifier: "AttributionTableViewCell", for: indexPath) as? AttributionTableViewCell,
                let model = model as? AttributionModel {
                attributionCell.configure(model: model)
                attributionCell.tappedYummlyLink = { [weak self] in
                    if let wellformedUrl = model.urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                        let url = URL(string: wellformedUrl) {
                        let safariVC = SFSafariViewController(url: url)
                        self?.present(safariVC, animated: true, completion: nil)
                    }
                }
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

extension RecipeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxDistanceAlpha: CGFloat = 100.0
        let percentScrolled = scrollView.contentOffset.y / maxDistanceAlpha
        if percentScrolled < 0 {
            self.recipeNameLabel.alpha = 0
        } else if percentScrolled > 1 {
            self.recipeNameLabel.alpha = 1
        } else {
            self.recipeNameLabel.alpha = percentScrolled
        }
    }
}
