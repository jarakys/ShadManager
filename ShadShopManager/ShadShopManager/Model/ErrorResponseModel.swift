//
//  ErrorResponseModel.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 07.09.2021.
//

import Foundation

struct ErrorResponseModel: Codable{
    let error: Bool
    let reason: String
}
