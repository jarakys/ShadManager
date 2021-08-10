//
//  ReusableCell.swift
//  ShadShopManager
//
//  Created by Kirill on 10.08.2021.
//

import UIKit

protocol ReusableCell: AnyObject {
    static var reusableIndentify: String { get }
    static var nib: UINib { get }
}

extension ReusableCell {
    static var reusableIndentify: String{
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
