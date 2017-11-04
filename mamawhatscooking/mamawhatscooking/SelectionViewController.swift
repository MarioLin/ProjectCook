//
//  SelectionViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 10/19/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import Foundation
import UIKit

protocol SelectionViewControllerDelegate {
    
}

class SelectionViewController: BaseViewController {
    let selectionEntities: [SelectionEntity]
    let tableView = UITableView()
    
    init(selections: [SelectionEntity]) {
        selectionEntities = selections
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(tableView)
        tableView.backgroundColor = .orange
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.size = CGSize(width: view.width, height: 400)
        tableView.center = view.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}

extension SelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectionEntities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") ??
            UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell");
        configure(cell, with: selectionEntities[indexPath.row])
        return cell
    }
    
    private func configure(_ cell: UITableViewCell, with model: SelectionEntity) {
        cell.textLabel?.text = model.displayName
        cell.backgroundColor = .orange
        cell.accessoryType = model.isChecked ? .checkmark : .none
    }
}
