//
//  LoginViewController.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 27.07.2021.
//

import UIKit
import Alamofire

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    //http://127.0.0.1:8080/auth/login
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 15
        registerButton.layer.cornerRadius = 15
    }
    
    @IBAction func Login(_ sender: UIButton) {

        if let login = emailTextField.text, login.isMatch(regexEmail) {
            if let password = passTextField.text, password.isMatch(regexPass) {

                let modelLogin = UserRequestModel(login: login, password: password)
                AuthManager.shareInstance.callingLogin(userLogin: modelLogin, completionHandler: { (result) in
                    switch result{
                    case .success(let json):
                        print(json as AnyObject)
                        let userId = (json).id
                        let loginRP = (json ).login
                        let connectedService = (json ).connectedServices
                        let token = (json ).token
                        //                        let loginRP = (json as AnyObject).value(forKey: "login") as! String
                        //                        let connectedService = (json as AnyObject).value(forKey: "connectedService") as! String
                        //                        let token = (json as AnyObject).value(forKey: "token") as! String
                        let modelUserResponse = UserResponseModel(id: userId, login: loginRP, connectedServices: connectedService, token: token)
                        print(modelUserResponse)

                        let alert = UIAlertController(title: "your account", message: "login: \(modelUserResponse.login), token: \(modelUserResponse.token), connect\(modelUserResponse.connectedServices)", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK",style: UIAlertAction.Style.default, handler: {(action: UIAlertAction) in

                            let storyboard = UIStoryboard.storyboard(storyboard: .main)
                            let tabBarController: UITabBarController = storyboard.instantiateViewController()
                            UIApplication.shared.windows.first?.rootViewController = tabBarController
                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                        }))
                        self.present(alert, animated: true, completion: nil)


                    case .failure(let err):
                        
                        print(err.localizedDescription)
                        let alert = UIAlertController(title: "Alert", message: "\(err.message)", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK",style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
        }else{
            let alert = UIAlertController(title: "Alert", message: "Invalid format", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK",style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
