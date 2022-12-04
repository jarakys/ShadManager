//
//  UserResponseModel.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 29.08.2021.
//

import Foundation

struct UserResponseModel: Codable {
   let id: String
   let login: String
   let connectedServices: [ConnectedServiceModel]
   let token: String 
}
