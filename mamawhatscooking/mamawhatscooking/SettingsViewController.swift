//
//  SettingsViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 1/4/18.
//  Copyright © 2018 Mario Lin. All rights reserved.
//

import UIKit
import SafariServices

private enum Sections: Int {
    case CustomSectionNum = 0
    case AttributeSectionNum
    case OpenSourceSectionNum
}

struct CustomizationSetting {
    let title: String
    let isOn: Bool
    let switchTapped: (_ isOn: Bool) -> ()
}

struct AttributionSetting {
    let title: String
    let subtitle: String
    let url: String?
}

struct OpenSourceAttribution {
    let title: String
}

class DequeuableSubtitleCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SettingsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: tableView sections
    fileprivate var customizationSection = [CustomizationSetting]()
    fileprivate var attributionSection = [AttributionSetting]()
    fileprivate var openSourceSection = [OpenSourceAttribution]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        exitButton.setImage(#imageLiteral(resourceName: "exit").imageWithColor(color: .yummyOrange), for: .normal)
        
        setupTableViewModels()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(UINib(nibName: "CustomizationTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CustomizationTableViewCell")
        
        tableView.register(DequeuableSubtitleCell.self, forCellReuseIdentifier: "DequeuableSubtitleCell")
    }
    
    private func setupTableViewModels() {
        let vegetarianSetting = CustomizationSetting(title: "Vegetarian Mode", isOn: UserDefaults.getDefaultForVegetarianOption()) { isOn in
            UserDefaults.setDefaultForVegetarianOption(isOn: isOn)
        }
        customizationSection.append(vegetarianSetting)
        
        let icons8Setting = AttributionSetting(title: "All icons are provided by Icons8",
                                               subtitle: "Tap here to see all their icons!",
                                               url: "https://icons8.com/")
        let yummly = AttributionSetting(title: "Recipe data is provided by Yummly",
                                        subtitle: "Tap here to see their website for more recipes!",
                                        url: "https://www.yummly.com/")
        attributionSection.append(contentsOf: [icons8Setting, yummly])

        let shimmer = OpenSourceAttribution(title: "Shimmer")
        let snapKit = OpenSourceAttribution(title: "SnapKit")
        openSourceSection.append(contentsOf: [shimmer, snapKit])
    }
    
    // MARK: IBActions
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == Sections.AttributeSectionNum.rawValue {
            let model = attributionSection[indexPath.row]
            if let wellformedUrl = model.url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                let url = URL(string: wellformedUrl) {
                let safariVC = SFSafariViewController(url: url)
                self.present(safariVC, animated: true, completion: nil)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Sections.CustomSectionNum.rawValue:
            let model = customizationSection[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomizationTableViewCell", for: indexPath) as? CustomizationTableViewCell {
                cell.customizationLabel.text = model.title
                cell.customizationSwitch.isOn = model.isOn
                cell.valueChangedBlock = { UserDefaults.setDefaultForVegetarianOption(isOn: $0) }
                cell.selectionStyle = .none
                return cell
            }
        case Sections.AttributeSectionNum.rawValue:
            let model = attributionSection[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DequeuableSubtitleCell", for: indexPath) as? DequeuableSubtitleCell {
                cell.textLabel?.text = model.title
                cell.detailTextLabel?.text = model.subtitle
                return cell
            }
        
        case Sections.OpenSourceSectionNum.rawValue:
            let model = openSourceSection[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = model.title
            return cell
        
        default:
            assertionFailure("model's & cell not properly configured")
        }
        assertionFailure("model's & cell not properly configured")
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case Sections.CustomSectionNum.rawValue: return "User Customization"
        case Sections.AttributeSectionNum.rawValue: return "Icons and recipe data"
        case Sections.OpenSourceSectionNum.rawValue: return "Open source libraries used"
        default: return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.CustomSectionNum.rawValue: return customizationSection.count
        case Sections.AttributeSectionNum.rawValue: return attributionSection.count
        case Sections.OpenSourceSectionNum.rawValue: return openSourceSection.count
        default: return 0
        }
        
    }
}
