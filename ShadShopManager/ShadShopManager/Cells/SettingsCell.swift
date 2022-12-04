//
//  SettingsCell.swift
//  ShadShopManager
//
//  Created by Kirill on 14.08.2021.
//

import UIKit

class SettingsCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    private var node: SettingViewModel.Section.Node?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(node: SettingViewModel.Section.Node) {
        self.node = node
        titleLabel.text = node.title.description
        settingSwitch.isOn = node.isOn
        settingSwitch.isHidden = node.hideToggle
    }

    @IBAction func valueDidChanged(_ sender: Any) {
        node?.tapAction?(settingSwitch.isOn)
    }
}
