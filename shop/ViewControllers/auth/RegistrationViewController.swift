//
//  RegistrationViewController.swift
//  shop
//
//  Created by Perejro on 23/11/2024.
//

import UIKit

final class RegistrationViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var service = UsersDataStore.shared
    
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
            // Убедимся, что destination — это UINavigationController
            if let navigationController = segue.destination as? UINavigationController {
                if let vc = navigationController.viewControllers.first as? HomeViewViewController {
                    if let user = sender as? User {
                        print("Sender is of type User")
                        vc.user = user
                    }
                }
            }
        }
    }

    @IBAction func registrationButtonAction() {
        guard let login = loginTextField.text, !login.isEmpty else {
            showAlert(title: "Ooops!", message: "Please enter a login.")
            return
        }

        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Ooops!", message: "Please enter a password.")
            return
        }

        let candidate = service.findUserByLogin(with: login)

        if candidate != nil {
            showAlert(title: "Ooops!", message: "User with this login already exists.")
            return
        }
        
        let user = User(login: login, password: password)
        service.add(user)
        
        performSegue(withIdentifier: "home", sender: user)
    }
}

private extension RegistrationViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
