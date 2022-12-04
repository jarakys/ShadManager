//
//  ConnectedServiceType.swift
//  ShadShopManager
//
//  Created by Kirill on 11.09.2021.
//

import Foundation

enum ConnectedServiceType: String, Codable, CaseIterable {
    case instagram
    case rozetka
    case promUA
    case wooCommerce
    
    var description: String {
        switch self {
        case .instagram:
            return "Instagram"
        case .rozetka:
            return "Rozetka"
        case .promUA:
            return "PromUA"
        case .wooCommerce:
            return "WooCommerce"
        }
    }
    
    func connect<T: Codable>(completion: @escaping(Result<T, Error>) -> Void) {
        switch self {
        case .instagram:
            connectedInstagram(completion: completion)
        default:
            break
        }
    }
    
    func update<T: Codable>(completion: @escaping(Result<T, Error>) -> Void) {
        switch self {
        case .instagram:
            connectedInstagram(completion: completion)
        default:
            break
        }
    }
    
    private func connectedInstagram<T: Codable>(completion: @escaping(Result<T, Error>) -> Void) {
        InstagramManager.shared.login(completion: { result in
            if case let .success(response) = result {
                let jsonEncoder = JSONEncoder()
                guard let jsonData = try? jsonEncoder.encode(response),
                      let json = String(data: jsonData, encoding: String.Encoding.utf16) as? T
                else {
                    completion(.failure(InstagramError.loginError))
                    return
                }
                completion(.success(json))
            } else if case let .failure(error) = result {
                completion(.failure(error))
            } else {
                completion(.failure(InstagramError.loginError))
            }
        })
    }
}
