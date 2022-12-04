//
//  UserManager.swift
//  ShadShopManager
//
//  Created by Kirill on 11.09.2021.
//

import Foundation

class UserManager {
    
    public static let shared = UserManager()
    
    private(set) var user: UserModel?
    
    private init() { }
    
    func login(userResponseModel: UserResponseModel) {
        user = UserModel(token: userResponseModel.token, connectedServices: userResponseModel.connectedServices)
    }
    
    func logout() {
        user = nil
    }
}
