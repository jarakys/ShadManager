//
//  SettingsServiceHeader.swift
//  ShadShopManager
//
//  Created by Kirill on 11.09.2021.
//

import UIKit

class SettingsServiceHeader: UITableViewHeaderFooterView, ReusableCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    private var section: SettingViewModel.Section?
    
    func configure(sectionModel: SettingViewModel.Section) {
        self.section = sectionModel
        titleLabel.text = sectionModel.title
        countLabel.text = sectionModel.nodes.count.description
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        section?.isExpanded.toggle()
    }
}
