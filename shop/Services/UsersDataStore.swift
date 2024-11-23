//
//  UsersDataStore.swift
//  shop
//
//  Created by Perejro on 23/11/2024.
//

import Foundation

class UsersDataStore {
    static let shared = UsersDataStore()

    var users: [User] = [
        User(login: "root", password: "root", email: "root@root.root")
    ]
    
    private init() {}
    
    func add(_ user: User) {
        users.append(user)
    }
    
    func findUserByLogin(with login: String) -> User? {
        users.first(where: { $0.login == login })
    }
    
    func getbyLogin(_ login: String) -> User? {
        users.first(where: { $0.login == login })
    }
    
    func comparePasswords(_ password: String, with user: User) -> Bool {
        password == user.password
    }
    
}
