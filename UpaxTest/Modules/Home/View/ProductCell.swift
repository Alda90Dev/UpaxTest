//
//  ProductCell.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation
import UIKit
import SDWebImage

class ProductCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ProductCell.self)
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: -2);
        view.layer.shadowOpacity = 0.75
        view.layer.shadowRadius = 8
        return view
    }()
    
    private lazy var imgProduct: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var imgMainProduct: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    private lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 2
        lbl.textColor = ColorCatalog.dark
        lbl.font = UIFont.systemFont(ofSize: 18.0)
        return lbl
    }()
    
    private lazy var lblBrand: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.placeholder
        lbl.font = UIFont.systemFont(ofSize: 12.0)
        return lbl
    }()
    
    private lazy var imgDots: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.image = ImageCatalog.dots
        return img
    }()
    
    private lazy var lblDescription: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = ColorCatalog.text
        lbl.font = UIFont.systemFont (ofSize: 14.0)
        return lbl
    }()
    
    private lazy var btnLike: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("", for: .normal)
        btn.setImage(ImageCatalog.heartLine.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    private lazy var imgComments: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleToFill
        img.image = ImageCatalog.comments
        return img
    }()
    
    private lazy var lblPrice: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.dark
        lbl.font = UIFont.systemFont(ofSize: 16.0)
        return lbl
    }()
    
    var imageURL: URL? {
        didSet {
            setupImage()
        }
    }
    
    var mainImageURL: URL? {
        didSet {
            setupMainImage()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(product: Product) {
        lblTitle.text = product.title ?? ""
        lblBrand.text = product.brand ?? ""
        lblDescription.text = product.description ?? ""
        if let price = product.price {
            lblPrice.text = "$\(price)"
        }
        imageURL = product.thumbnailURL()
        mainImageURL = product.firstImageURL()
        
        setupview()
    }
    
    override func layoutSubviews() {
        imgProduct.layer.cornerRadius = imgProduct.frame.size.width / 2
    }
}

private extension ProductCell {
    func setupview() {
        selectionStyle = .none
        backgroundColor = .clear
        
        titleStackView.addArrangedSubview(lblTitle)
        titleStackView.addArrangedSubview(lblBrand)
        
        mainView.addSubview(imgProduct)
        mainView.addSubview(imgDots)
        mainView.addSubview(titleStackView)
        mainView.addSubview(lblDescription)
        mainView.addSubview(imgMainProduct)
        mainView.addSubview(btnLike)
        mainView.addSubview(imgComments)
        mainView.addSubview(lblPrice)
        
        addSubview(mainView)
        setConstraints()
    }
    
    func setConstraints() {
        let constraintsArray = [
            
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            imgProduct.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            imgProduct.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            imgProduct.heightAnchor.constraint(equalToConstant: 45),
            imgProduct.widthAnchor.constraint(equalToConstant: 45),
            
            imgDots.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            imgDots.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            imgDots.heightAnchor.constraint(equalToConstant: 25),
            imgDots.widthAnchor.constraint(equalToConstant: 35),
            
            titleStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            titleStackView.leadingAnchor.constraint(equalTo: imgProduct.trailingAnchor, constant: 16),
            titleStackView.trailingAnchor.constraint(equalTo: imgDots.leadingAnchor, constant: -16),
            
            lblDescription.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 16),
            lblDescription.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 77),
            lblDescription.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            
            imgMainProduct.topAnchor.constraint(equalTo: lblDescription.bottomAnchor, constant: 16),
            imgMainProduct.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 77),
            imgMainProduct.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            imgMainProduct.heightAnchor.constraint(equalToConstant: 100),
            imgMainProduct.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -61),
            
            btnLike.topAnchor.constraint(equalTo: imgMainProduct.bottomAnchor, constant: 16),
            btnLike.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 77),
            btnLike.heightAnchor.constraint(equalToConstant: 35),
            btnLike.widthAnchor.constraint(equalToConstant: 35),
            
            imgComments.topAnchor.constraint(equalTo: imgMainProduct.bottomAnchor, constant: 23),
            imgComments.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 128),
            imgComments.heightAnchor.constraint(equalToConstant: 25),
            imgComments.widthAnchor.constraint(equalToConstant: 25),

            lblPrice.topAnchor.constraint(equalTo: imgMainProduct.bottomAnchor, constant: 16),
            lblPrice.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            lblPrice.heightAnchor.constraint(equalToConstant: 45),
            lblPrice.widthAnchor.constraint(equalToConstant: 50),
            
        ]
        
        NSLayoutConstraint.activate(constraintsArray)
        
    }
    
    func setupImage() {
        if let url = imageURL {
            imgProduct.sd_setImage(with: url)
        }
    }
    
    func setupMainImage() {
        if let url = mainImageURL {
            imgMainProduct.sd_setImage(with: url)
        }
    }
}
