//
//  ConnectedServiceModel.swift
//  ShadShopManager
//
//  Created by Kirill on 11.09.2021.
//

import Foundation

struct ConnectedServiceModel: Codable {
    let authData: String
    let accountName: String
    let service: ConnectedServiceType
    let isOn: Bool
}
