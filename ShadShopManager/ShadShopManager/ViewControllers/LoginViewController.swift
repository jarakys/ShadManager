//
//  LoginViewController.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 27.07.2021.
//

import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 15

        registerButton.layer.cornerRadius = 15

    }
 
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @available(iOS 14, *)
    @IBAction func Login(_ sender: UIButton) {
        guard let quotesViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ImagesViewController") as? ImagesViewController else {
               fatalError("Unable to Instantiate Quotes View Controller")
           }
        navigationController?.pushViewController(quotesViewController, animated: false)
     }
}


