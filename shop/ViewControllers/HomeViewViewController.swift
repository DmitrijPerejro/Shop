//
//  HomeViewViewController.swift
//  shop
//
//  Created by Perejro on 22/11/2024.
//

import UIKit

class HomeViewViewController: UIViewController {
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet var categoryButtons: [UIButton]!
    
    let products = Product.fetch()
    var user: User!
    
    private var currentCategoryIndex = 0
    private let labels = ["Shoes", "Clothes", "Bags"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "product")
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        initCategoryButtons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserViewController {
            destination.user = user
        }
        
        if let destionation = segue.destination as? ProductDetailsViewController {
            destionation.product = sender as? Product
            destionation.user = user
        }
        
        if let destionation = segue.destination as? CartViewController {
            destionation.user = user
        }
    }
    
    @IBAction func categoryButtonAction(_ sender: UIButton) {
        currentCategoryIndex = sender.tag
        
        categoryButtons.forEach { button in
            button.tintColor = .black
            button.backgroundColor = .systemGray6
        }
        
        categoryButtons[sender.tag].tintColor = .white
        categoryButtons[sender.tag].backgroundColor = .black
    }
        
    private func initCategoryButtons() {
        categoryButtons.enumerated().forEach { (index, button) in
            categoryButtons[index].layer.cornerRadius = categoryButtons[index].frame.height / 2
            categoryButtons[index].setTitle(labels[index], for: .normal)
            
            if index != 0 {
                categoryButtons[index].tintColor = .black
                categoryButtons[index].backgroundColor = .systemGray6
                categoryButtons[index].isEnabled = false
            } else {
                categoryButtons[index].tintColor = .white
                categoryButtons[index].backgroundColor = .black
            }
       
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }

        let product = products[indexPath.row]
        productCell.configure(with: product)
        return productCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        
        
        performSegue(withIdentifier: "productDetails", sender: product)
    }
    
}
