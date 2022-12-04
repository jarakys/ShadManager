//
//  APIManager.swift
//  ShadShopManager
//
//  Created by Kirill on 10.09.2021.
//

import Foundation

class APIManager {
    public static var shared = APIManager()
    
    private init() {}
    
    public func connectService(connectedServiceModel: ConnectedServiceModel, userToken: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
}
