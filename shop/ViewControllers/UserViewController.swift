//
//  UserViewController.swift
//  shop
//
//  Created by Perejro on 22/11/2024.
//

import UIKit

final class UserViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var secureButton: UIButton!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = user.email.isEmpty ? user.login : user.email
        loginTextField.text = user.login
        passwordTextField.text = user.password
        emailTextField.text = user.email
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func secureChangeModeAction() {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
            secureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            secureButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }

    @IBAction func saveChangesAction() {
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        if [login, password, email].allSatisfy({ !$0.isEmpty }) {
            makeAlert(
                title: "Вы уверены?",
                message: "Новые данные будут сохранены",
                actions: [
                    UIAlertAction(
                        title: "Save",
                        style: .default,
                        handler: { _ in
                            let login = self.loginTextField.text ?? ""
                            let email = self.emailTextField.text ?? ""
                            let password = self.passwordTextField.text ?? ""
                            
                            self.user.changeField(for: .login, login)
                            self.user.changeField(for: .email, email)
                            self.user.changeField(for: .password, password)
                            
                            self.navigationItem.title = email.isEmpty ? login : email
                        }
                    ),
                    UIAlertAction(
                        title: "Cancel",
                        style: .destructive,
                        handler: { _ in
                            self.setDefaultValues()
                        }
                    )
                ]
            )
        } else {
            makeAlert(
                title: "Ошибка!",
                message: "Не все поля заполнены",
                actions: [
                    UIAlertAction(
                        title: "OK",
                        style: .destructive
                    )
                ]
            )
        }
    }
    
    @IBAction func cancelChangesAction(_ sender: Any) {
        setDefaultValues()
    }
    
    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    private func makeAlert(title: String, message: String, actions: [UIAlertAction] = []) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
    
    private func setDefaultValues() {
        loginTextField.text = user.login
        emailTextField.text = user.email
        passwordTextField.text = user.password
    }
}

// MARK: - UITextFieldDelegate
extension UserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
