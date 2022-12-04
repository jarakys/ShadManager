//
//  SettingsViewController.swift
//  ShadShopManager
//
//  Created by Kirill on 14.08.2021.
//

import UIKit
import Combine
import SwiftyInsta

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    private var cancellable: [Cancellable?] = []
    
    private lazy var viewModel: SettingViewModel =  {
        return SettingViewModel()
    }()
    
    deinit {
        cancellable = []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.register(SettingsCell.nib, forCellReuseIdentifier: SettingsCell.reusableIndentify)
        settingsTableView.register(SettingsServiceHeader.nib, forHeaderFooterViewReuseIdentifier: SettingsServiceHeader.reusableIndentify)
        cancellable.append(viewModel.$sections.sink(receiveValue: {[weak self] _ in
            self?.settingsTableView.reloadData()
        }))
        cancellable.append(viewModel.$updateSection.sink(receiveValue: {[weak self] value in
            self?.settingsTableView.reloadData()
        }))
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsServiceHeader.reusableIndentify)
        (headerView as? SettingsServiceHeader)?.configure(sectionModel: viewModel.sections[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].isExpanded ? viewModel.sections[section].nodes.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reusableIndentify, for: indexPath)
        let node = viewModel.sections[indexPath.section].nodes[indexPath.row]
        (cell as? SettingsCell)?.configure(node: node)
        return cell
    }
}
