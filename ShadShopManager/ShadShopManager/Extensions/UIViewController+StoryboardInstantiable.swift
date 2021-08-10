//
//  UIViewController+StoryboardInstantiable.swift
//  ShadShopManager
//
//  Created by Kirill on 10.08.2021.
//

import UIKit

protocol StoryboardInstantiable {
}

extension StoryboardInstantiable where Self: UIViewController {
    static var className: String {
        return String(describing: Self.self)
    }
}

extension UIViewController: StoryboardInstantiable {
}

extension UIStoryboard {
    enum Storyboard: String {
        case auth
        case main
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    func instantiateViewController<T: UIViewController>() -> T  {
        guard let viewController = self.instantiateViewController(withIdentifier: T.className) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.className) ")
        }
        return viewController
    }
    
    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
}
