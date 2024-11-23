//
//  Cart.swift
//  shop
//
//  Created by Perejro on 22/11/2024.
//

import Foundation

class Cart {
    var items: [Product] = []
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    func addProduct(_ product: Product) {
        items.append(product)
    }
    
    func removeProduct(_ product: Product) {
        items.removeAll(where: { $0.id == product.id })
    }
    
    func contains(_ product: Product) -> Bool {
        items.contains(where: { $0.id == product.id })
    }
    
    func clear() {
        items.removeAll()
    }
}
