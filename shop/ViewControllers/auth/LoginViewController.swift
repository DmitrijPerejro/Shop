//
//  LoginViewController.swift
//  shop
//
//  Created by Perejro on 23/11/2024.
//

import UIKit

final class LoginViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var service = UsersDataSource.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            if let navigationController = segue.destination as? UINavigationController {
                if let vc = navigationController.viewControllers.first as? HomeViewViewController {
                    if let user = sender as? User {
                        vc.user = user
                    }
                }
            }
        }
    }
    
    @IBAction func forgotAction() {
        let login = service.users.first?.login ?? "";
        let password = service.users.first?.password ?? "";
        
        let alert = UIAlertController(
            title: "Forgot?",
            message: "login: \(login). Password: \(password)",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.loginTextField.text = login
            self.passwordTextField.text = password
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonAction() {
        guard let login = loginTextField.text, !login.isEmpty else {
            showAlert(title: "Ooops!", message: "Please enter a login.")
            return
        }

        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Ooops!", message: "Please enter a password.")
            return
        }

        let candidate = service.findUserByLogin(with: login)

        if candidate == nil {
            showAlert(title: "Ooops!", message: "User with this login doesn't exist.")
            return
        }
        
        if let candidate = candidate {
            let isValidPassword = service.comparePasswords(password, with: candidate)
            
            if !isValidPassword {
                showAlert(title: "Ooops!", message: "Invalid password.")
                return
            }
            
            clearFields()

            performSegue(withIdentifier: "home", sender: candidate)
        }
    }
        
    private func clearFields() {
        loginTextField.text = ""
        passwordTextField.text = ""
    }
}

// MARK: - UIAlertController
private extension LoginViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
