//
//  CommentCell.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation
import UIKit

class CommentCell: UITableViewCell {
    static let reuseIdentifier = String(describing: CommentCell.self)
    
    private lazy var imgUserComment: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var lblUser: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.principal
        lbl.font = UIFont.systemFont(ofSize: 16.0)
        return lbl
    }()
    
    private lazy var lblBody: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.text
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        return lbl
    }()
    
    private lazy var lblPostID: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.placeholder
        lbl.font = UIFont.systemFont(ofSize: 12.0)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(comment: Comment) {
        lblUser.text = comment.user.username
        lblBody.text = comment.body
        lblPostID.text = "\(comment.postID)"
        let n = Int.random(in: 1...6)
        imgUserComment.image = UIImage(named: "img\(n)")
        setupview()
    }
    
    override func layoutSubviews() {
        imgUserComment.layer.cornerRadius = imgUserComment.frame.size.width / 2
    }
}


private extension CommentCell {
    func setupview() {
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(imgUserComment)
        addSubview(lblUser)
        addSubview(lblBody)
        addSubview(lblPostID)
        
        setConstraints()
    }
    
    func setConstraints() {
        let constraintsArray = [
            
            imgUserComment.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imgUserComment.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imgUserComment.heightAnchor.constraint(equalToConstant: 60),
            imgUserComment.widthAnchor.constraint(equalToConstant: 60),
            
            lblUser.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            lblUser.leadingAnchor.constraint(equalTo: imgUserComment.trailingAnchor, constant: 16),
            lblUser.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            lblPostID.topAnchor.constraint(equalTo: lblUser.bottomAnchor, constant: 16),
            lblPostID.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            lblPostID.widthAnchor.constraint(equalToConstant: 50),
            
            lblBody.topAnchor.constraint(equalTo: lblUser.bottomAnchor, constant: 16),
            lblBody.leadingAnchor.constraint(equalTo: imgUserComment.trailingAnchor, constant: 16),
            lblBody.trailingAnchor.constraint(equalTo: lblPostID.leadingAnchor, constant: -16),
            lblBody.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            
        ]
        
        NSLayoutConstraint.activate(constraintsArray)
        
    }
}
