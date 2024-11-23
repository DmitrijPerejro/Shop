//
//  User.swift
//  shop
//
//  Created by Perejro on 22/11/2024.
//

import Foundation

class User {
    enum Field {
        case login, password, email
    }
    
    var login: String
    var password: String
    var email: String
    let cart: Cart
    
    init(login: String, password: String, email: String = "", cart: Cart = Cart()) {
        self.login = login
        self.password = password
        self.email = email
        self.cart = cart
    }
    
    func changeField(for field: Field, _ value: String) {
        switch field {
        case .login:
            login = value
        case .password:
            password = value
        default:
            email = value
        }
    }
}
