//
//  RegisterModel.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 22.08.2021.
//

import Foundation

struct UserRequestModel: Encodable{
    let login: String
    let password: String
}
