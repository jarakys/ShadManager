//
//  String+isMatch.swift
//  ShadShopManager
//
//  Created by Kirill on 10.08.2021.
//

import Foundation

extension String {
    func isMatch(_ regex: String) -> Bool{
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
