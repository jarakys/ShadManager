//
//  AuthConstant.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 22.08.2021.
//

import Foundation

let baseUrl = "http://127.0.0.1:8080/auth"
let registerUrl = "\(baseUrl)/register"
let loginUrl = "\(baseUrl)/login"

let regexEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

let regexPass = "[A-Z0-9a-z]{8,}"
