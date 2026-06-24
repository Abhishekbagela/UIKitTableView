//
//  ProductListCell.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 20/06/26.
//

import UIKit

class ProductListCell: UITableViewCell {
    var productId: Int?
    var imageTask: Task<Void, Never>?
    
    var productImageView = UIImageView()
    var titleLabelView = UILabel()
    var descLabelView  = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(productImageView)
        addSubview(titleLabelView)
        addSubview(descLabelView)
        
        configureImage()
        configureTitle()
        configureDesc()
        
        setImageConstraints()
        setTitleConstraints()
        setDescConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not been implemented")
    }
    
    func setCellData(product: Product, image: UIImage?) {
        productImageView.image = image
        titleLabelView.text = product.title
        descLabelView.text = product.description
        
        productImageView.layoutIfNeeded()
    }
    
    private func configureImage() {
        productImageView.layer.cornerRadius = 8
        productImageView.clipsToBounds = true
    }
    
    private func configureTitle() {
        titleLabelView.numberOfLines = 0
        titleLabelView.adjustsFontSizeToFitWidth = true
    }
    
    private func configureDesc() {
        descLabelView.numberOfLines = 0
        descLabelView.adjustsFontSizeToFitWidth = true
    }
    
    private func setImageConstraints() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        productImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor, multiplier: 16/9).isActive  = true
    }
    
    private func setTitleConstraints() {
        titleLabelView.translatesAutoresizingMaskIntoConstraints = false
        titleLabelView.centerYAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        titleLabelView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20).isActive = true
        titleLabelView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleLabelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    private func setDescConstraints() {
        descLabelView.translatesAutoresizingMaskIntoConstraints = false
        descLabelView.centerYAnchor.constraint(equalTo: titleLabelView.bottomAnchor, constant: 20).isActive = true
        descLabelView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20).isActive = true
        descLabelView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        descLabelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        imageTask = nil
        
        productImageView.image = nil
        titleLabelView.text = nil
        descLabelView.text = nil
    }
}
