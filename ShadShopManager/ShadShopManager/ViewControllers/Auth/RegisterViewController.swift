//
//  RegisterViewController.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 30.07.2021.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var backToLogButton: UIButton!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPassLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.cornerRadius = 15
        backToLogButton.layer.cornerRadius = 15
    }
    
    @IBAction func headBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        if let email = emailTextField.text, email.isMatch(regexEmail) {
            if let password = passTextField.text, password.isMatch(regexPass) {
                let registerModel = UserRequestModel(login: email, password: password)
                AuthManager.shareInstance.callingRegister(user: registerModel, completionHandler: {(result) in
                    
                    switch (result) {
                    case .success(let model):
                        let alert = UIAlertController(title: "Success", message: "User register successfully", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK",style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    case .failure(let err):
                        let alert = UIAlertController(title: "Alert", message: "\(err.message)", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK",style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
            else {
                errorPassLabel.text = "Incorrct pass format"}
        }
        else {
            errorEmailLabel.text = "Incorrct email format"
        }
        
    }
}


