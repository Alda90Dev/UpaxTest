//
//  PostCell.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation
import UIKit

class PostCell: UITableViewCell {
    static let reuseIdentifier = String(describing: PostCell.self)
    
    private lazy var imgUserPost: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var lbltitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.dark
        lbl.font = UIFont.systemFont(ofSize: 16.0)
        return lbl
    }()
    
    private lazy var lblTags: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.placeholder
        lbl.font = UIFont.systemFont(ofSize: 12.0)
        return lbl
    }()
    
    private lazy var lblBody: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 3
        lbl.textColor = ColorCatalog.text
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(post: Post) {
        lbltitle.text = post.title
        lblBody.text = post.body
        lblTags.text = post.getTags()
        
        let n = Int.random(in: 1...6)
        imgUserPost.image = UIImage(named: "img\(n)")
        setupview()
    }
    
    override func layoutSubviews() {
        imgUserPost.layer.cornerRadius = imgUserPost.frame.size.width / 2
    }
}

private extension PostCell {
    func setupview() {
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(imgUserPost)
        addSubview(lbltitle)
        addSubview(lblBody)
        addSubview(lblTags)
        
        setConstraints()
    }
    
    func setConstraints() {
        let constraintsArray = [
            
            imgUserPost.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imgUserPost.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imgUserPost.heightAnchor.constraint(equalToConstant: 60),
            imgUserPost.widthAnchor.constraint(equalToConstant: 60),
            
            lbltitle.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            lbltitle.leadingAnchor.constraint(equalTo: imgUserPost.trailingAnchor, constant: 16),
            lbltitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            lblTags.topAnchor.constraint(equalTo: lbltitle.bottomAnchor, constant: 16),
            lblTags.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 92),
            lblTags.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            lblBody.topAnchor.constraint(equalTo: lblTags.bottomAnchor, constant: 16),
            lblBody.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 92),
            lblBody.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            lblBody.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            
        ]
        
        NSLayoutConstraint.activate(constraintsArray)
        
    }
}
