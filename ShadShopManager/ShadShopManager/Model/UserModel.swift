//
//  UserModel.swift
//  ShadShopManager
//
//  Created by Kirill on 11.09.2021.
//

import Foundation
import Combine

class UserModel {
    var token: String
    @Published var connectedServices: [ConnectedServiceModel]
    
    public init(token: String, connectedServices: [ConnectedServiceModel]) {
        self.token = token
        self.connectedServices = connectedServices
    }
}
