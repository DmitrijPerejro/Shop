//
//  ProductCollectionViewCell.swift
//  shop
//
//  Created by Perejro on 22/11/2024.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let imageView = UIImageView()
    private let stackView = UIStackView()
    
    // Взято от индусов
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    // Взято от индусов
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func configure(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "\(product.price)$"
        imageView.image = UIImage(named: product.image)
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 10
        
        titleLabel.textAlignment = .left
        priceLabel.textAlignment = .left
        
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(priceLabel)
    
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.widthAnchor.constraint(equalToConstant: contentView.frame.width - 32)
        ])
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imageView)
        

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
