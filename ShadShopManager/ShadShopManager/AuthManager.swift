//
//  APIManager.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 27.08.2021.
//

import Foundation
import Alamofire

enum AuthError: Error {
    case responseError(message: String)
    var message: String{
        switch self {
        case .responseError(message: let mess):
            return mess
        }
    }
    
}

class AuthManager{
    
    static let shareInstance = AuthManager()
    
    func callingRegister(user: UserRequestModel, completionHandler: @escaping (Result<Bool, AuthError>)-> ()){
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(registerUrl, method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let .some(data)):
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(true))
                    }else{
                        let jsonErr =  try JSONDecoder().decode(ErrorResponseModel.self, from: data)
                        completionHandler(.failure(AuthError.responseError(message: "\(jsonErr.reason)")))
                    }
                }catch{
                    print(error.localizedDescription)
                    completionHandler(.failure(AuthError.responseError(message: "conten error")))
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(.failure(AuthError.responseError(message: "")))
            default:
                completionHandler(.failure(AuthError.responseError(message: "xz chto poshlo ne tak")))
            }
        }
    }
    
    func callingLogin(userLogin: UserRequestModel, completionHandler: @escaping (Result<UserResponseModel, AuthError>)-> ()) {
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(loginUrl, method: .post, parameters: userLogin, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            switch response.result{
            case .success(let .some(data)):
                do {
                    
                    // let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    if response.response?.statusCode == 200 {
                        //                      completionHandler(.success(json))
                        let json = try JSONDecoder().decode(UserResponseModel.self, from: data)
                        print(json)
                        completionHandler(.success(json))
                    } else {
                        
                        let jsonErr =  try JSONDecoder().decode(ErrorResponseModel.self, from: data)
                        completionHandler(.failure(AuthError.responseError(message: jsonErr.reason)))
                    }
                } catch {
                    print(error.localizedDescription)
                    
                    completionHandler(.failure(AuthError.responseError(message: "Try again")))
                }
            case .failure(let err):
                print(err.localizedDescription)
                //           let jsonErr = JSONDecoder().decode(ErrorResponseModel, from: data)
                completionHandler(.failure(AuthError.responseError(message: "user not found")))
            default:
                completionHandler(.failure(AuthError.responseError(message: "xz chto poshlo ne tak")))
            }
        }
    }
}
