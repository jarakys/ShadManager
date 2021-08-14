//
//  SettingsViewController.swift
//  ShadShopManager
//
//  Created by Kirill on 14.08.2021.
//

import UIKit
import Combine

enum Settings: CaseIterable {
    case instagram
    case rozetka
    case promUA
    case wooCommerce
    
    var description: String {
        switch self {
        case .instagram:
            return "Instagram"
        case .rozetka:
            return "Rozetka"
        case .promUA:
            return "PromUA"
        case .wooCommerce:
            return "WooCommerce"
        }
    }
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    private var cancellable: Cancellable?
    
    private lazy var viewModel: SettingViewModel =  {
        return SettingViewModel()
    }()
    
    deinit {
        cancellable = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.register(SettingsCell.nib, forCellReuseIdentifier: SettingsCell.reusableIndentify)
        cancellable = viewModel.$nodes.sink(receiveValue: {[weak self] _ in
            self?.settingsTableView.reloadData()
        })
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.nodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reusableIndentify, for: indexPath)
        let node = viewModel.nodes[indexPath.row]
        (cell as? SettingsCell)?.configure(node: node)
        return cell
    }
}
