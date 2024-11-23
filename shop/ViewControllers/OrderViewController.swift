//
//  OrderViewController.swift
//  shop
//
//  Created by Perejro on 22/11/2024.
//

import UIKit

final class OrderViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryPicker: UIPickerView!
    
    var user: User!
    var choosenCountry: String = "Ukraine"
    
    private let countries = [
        "Ukraine",
        "USA",
        "Germany",
        "France",
        "Italy",
        "Spain",
        "Poland",
        "United Kingdom",
        "Norway",
        "Sweden",
        "Finland",
        "Denmark",
        "Austria",
        "Switzerland",
        "Netherlands",
        "Belgium",
        "Portugal",
        "Czech Republic",
        "Hungary",
        "Greece"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPicker.delegate = self
        countryPicker.dataSource = self
        
        nameTextField.text = user.login
    }
    
    @IBAction func checkout() {
        let name = nameTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.text ?? ""
        let city = cityTextField.text ?? ""
        let country = choosenCountry

        if [name, phoneNumber, city, country].contains(where: { $0.isEmpty }) {
            let alert = UIAlertController(
                title: "Ошибка",
                message: "Не все поля заполнены",
                preferredStyle: .alert
            )
            
            alert.addAction(
                UIAlertAction(
                    title: "Ok",
                    style: .destructive,
                    handler: nil
                )
            )
            
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(
                title: "Заказ оформлен",
                message: "Спасибо за заказ, \(name).",
                preferredStyle: .actionSheet
            )
            
            alert.addAction(
                UIAlertAction(
                    title: "Ok",
                    style: .default
                )
            )
            
            present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension OrderViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choosenCountry = countries[row]
    }
}
