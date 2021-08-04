//
//  BaseViewController.swift
//  ShadShopManager
//
//  Created by Kyrylo Chernov on 30.07.2021.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.placeholder = "email"
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 15
        emailTextField.layer.borderColor = UIColor.black.cgColor
        
        passTextField.placeholder = "password"
        passTextField.layer.borderWidth = 1
        passTextField.layer.cornerRadius = 15
        passTextField.layer.borderColor = UIColor.black.cgColor
        
        registerKeyboardNotification()
        
       
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    deinit {
        removeKeyboardNotification()
        
    }
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                
            }
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification){
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            
        }
    }
    
    @IBAction func emailDone(_ sender: UITextField) {
        sender.resignFirstResponder()
        
    }
    
    @IBAction func passDone(_ sender: UITextField) {
        sender.resignFirstResponder()
        
    }
}

extension String {
    func isMatch(_ regex: String) -> Bool{
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
        
    }
}
