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
    
    private var regexEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    private var regexPass = "[A-Z0-9a-z]{8,}"
    
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
            errorEmailLabel.text = "done"
        }
        else {
            errorEmailLabel.text = "Incorrct email format"
        }
        if let password = passTextField.text, password.isMatch(regexPass) {
            errorPassLabel.text = "done"
        }
        else {
            errorPassLabel.text = "Incorrct pass format"}
    }
}


