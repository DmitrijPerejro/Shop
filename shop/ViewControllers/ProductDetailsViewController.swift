//
//  ProductDetailsViewController.swift
//  shop
//
//  Created by Perejro on 22/11/2024.
//

import UIKit

final class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    
    var product: Product!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = product.title
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        imageView.image = UIImage(named: product.image)
        
        if user.cart.contains(product) {
            cartButton.setTitle("Remove from cart", for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cart", let vc = segue.destination as? CartViewController {
            vc.user = user
        }
    }
    
    @IBAction func cartAction() {
        if user.cart.contains(product) {
            user.cart.removeProduct(product)
            
            let alert = UIAlertController(title: "Product removed", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
            
            present(alert, animated: true, completion: {
                self.cartButton.setTitle("Add to cart", for: .normal)
            })
        } else {
            user.cart.addProduct(product)
    
            let alert = UIAlertController(title: "Added to cart", message: nil, preferredStyle: .actionSheet)
            
            alert.addAction(
                UIAlertAction(
                    title: "Продолжить",
                    style: .cancel, handler: nil
                )
            )

            alert.addAction(
                UIAlertAction(
                    title: "Перейти в корзину",
                    style: .default,
                    handler: { _ in
                        self.performSegue(withIdentifier: "cart", sender: nil)
                    }
                )
            )
            
            present(alert, animated: true, completion: {
                self.cartButton.setTitle("Remove from cart", for: .normal)
            })
        }
    }
}
