//
//  SettingViewModel.swift
//  ShadShopManager
//
//  Created by Kirill on 14.08.2021.
//

import Foundation
import Combine

class SettingViewModel: ObservableObject {
    @Published private(set) var nodes = [SettingViewModel.Node]()
    
    public init() {
        let setting = Settings.instagram
        let node = Node(title: setting.description, isOn: false, tapAction: {[weak self] value in
            if value {
                InstagramManager.shared.login(completion: { _ in})
                self?.reloadNode()
            }
        })
        nodes.append(node)
    }
    
    public func reloadNode() {
        var nodes = [SettingViewModel.Node]()
        let setting = Settings.instagram
        let node = Node(title: setting.description, isOn: false, tapAction: {[weak self] value in
            if value {
                InstagramManager.shared.login(completion: { _ in})
                self?.reloadNode()
            }
        })
        nodes.append(node)
        self.nodes = nodes
    }
}


extension SettingViewModel {
    class Node {
        var title: String
        var isOn: Bool
        var tapAction: ((Bool) -> Void)?
        var valueChangedAction: ((Bool) -> Void)?
        
        public init(title: String, isOn: Bool, tapAction: ((Bool) -> Void)?) {
            self.title = title
            self.isOn = isOn
            self.tapAction = tapAction
        }
    }
}
