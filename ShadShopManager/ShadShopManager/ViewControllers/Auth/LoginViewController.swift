//
//  LoginViewController.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 27.07.2021.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 15
        registerButton.layer.cornerRadius = 15
    }
    
    @IBAction func Login(_ sender: UIButton) {
        let storyboard = UIStoryboard.storyboard(storyboard: .main)
        let tabBarController: UITabBarController = storyboard.instantiateViewController()
        UIApplication.shared.windows.first?.rootViewController = tabBarController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
     }
}
