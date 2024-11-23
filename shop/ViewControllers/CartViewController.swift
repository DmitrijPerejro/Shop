//
//  CartViewController.swift
//  shop
//
//  Created by Perejro on 22/11/2024.
//

import UIKit

final class CartViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        if user.cart.items.isEmpty {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? OrderViewController {
            vc.user = user
        }
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user.cart.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)
        let item = user.cart.items[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        content.secondaryText = "$\(item.price)"
        content.image = UIImage(named: item.image)
        content.imageProperties.maximumSize = CGSize(width: 50, height: 50)
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if (user.cart.items.isEmpty) {
            return "В корзине нет товаров"
        }
        
        return "К оплате $\(user.cart.totalPrice)"
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
