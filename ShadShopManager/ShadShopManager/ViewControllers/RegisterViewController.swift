//
//  RegisterViewController.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 30.07.2021.
//

import UIKit

class RegisterViewController: BaseViewController {

    private var regexEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    private var regexPass = "[A-Z0-9a-z]{8,}"
    
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var backToLogButton: UIButton!
    
    @IBOutlet weak var errorEmailLabel: UILabel!
    
    @IBOutlet weak var errorPassLabel: UILabel!
    
    @IBAction func headBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.cornerRadius = 15
        
        backToLogButton.layer.cornerRadius = 15
    
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
    
    if emailTextField.text != nil && emailTextField.text!.isMatch(regexEmail) {
           errorEmailLabel.text = "done"
  
       }
       else {
           errorEmailLabel.text = "Incorrct email format"
           
       }
       
       if passTextField.text != nil && passTextField.text!.isMatch(regexPass) {
           errorPassLabel.text = "done"
           
       }
       else {errorPassLabel.text = "Incorrct pass format"}
        
       }
}


