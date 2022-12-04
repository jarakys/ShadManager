//
//  SettingViewModel.swift
//  ShadShopManager
//
//  Created by Kirill on 14.08.2021.
//

import Foundation
import Combine
import SwiftyInsta

class SettingViewModel: ObservableObject {
    
    private var cancellable: [Cancellable?] = []
    
    @Published private(set) var sections = [SettingViewModel.Section]()
    @Published private(set) var updateSection = [Int]()
    
    private var connectedServices: [ConnectedServiceModel] {
        UserManager.shared.user?.connectedServices ?? []
    }
    
    public init() {
        initData()
    }
    
    public func initData() {
        cancellable = []
        
        cancellable.append(UserManager.shared.user?.$connectedServices.sink(receiveValue: {[weak self] _ in
            self?.initData()
        }))
        
        let connectedServicesSections = Dictionary(grouping: connectedServices, by: { item in
            item.service
        })
        
        for serviceType in connectedServicesSections.keys {
            let section = SettingViewModel.Section(title: serviceType.description, isExpanded: false, nodes: [], tapAction: { [weak self] expanded in
                self?.initData()
            })
            for service in connectedServicesSections[serviceType] ?? [] {
                let node = SettingViewModel.Section.Node(title: service.accountName, isOn: service.isOn, tapAction: { [weak self] isConnect in
                    serviceType.update(completion: { (result: Result<String, Error>) in
                        switch result {
                        case .success(let json):
                            break
                            //TODO: Update here already existed Service
                        case .failure(let error):
                            print(error)
                        }
                    })
                })
                section.nodes.append(node)
            }
            let addNewNode = SettingViewModel.Section.Node(title: "Add new", isOn: false, hideToggle: true, tapAction: { [weak self] _ in
                serviceType.connect(completion: { (result: Result<String, Error>) in
                    switch result {
                    case .success(let json):
                        break
                        //TODO: Connect new serrivce api call, than call reloadData() after response from server
                    case .failure(let error):
                        print(error)
                    }
                })
                
            })
            section.nodes.append(addNewNode)
            cancellable.append(section.$nodes.sink(receiveValue: {[weak self] _ in
                self?.initData()
            }))
            cancellable.append(section.$isExpanded.sink(receiveValue: {[weak self] _ in
                let index = self?.sections.firstIndex(where: { $0 === section })
                self?.updateSection = [3]
            }))
        }
    }
}

extension SettingViewModel {
    class Section {
        var title: String
        @Published var isExpanded: Bool
        @Published var nodes: [Node]
        var tapAction: ((Bool) -> Void)?
        
        public init(title: String, isExpanded: Bool, nodes: [Section.Node], tapAction: ((Bool) -> Void)?) {
            self.title = title
            self.isExpanded = isExpanded
            self.nodes = nodes
            self.tapAction = tapAction
        }
        
        class Node {
            var title: String
            var isOn: Bool
            var hideToggle: Bool
            var tapAction: ((Bool) -> Void)?
            
            public init(title: String, isOn: Bool, hideToggle: Bool = false, tapAction: ((Bool) -> Void)?) {
                self.title = title
                self.isOn = isOn
                self.hideToggle = hideToggle
                self.tapAction = tapAction
            }
        }
    }
}
