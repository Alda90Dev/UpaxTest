//
//  StackValues.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation
import UIKit

class StackValueRow: UIStackView {

    private lazy var lblNum: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.dark
        lbl.font = UIFont.systemFont(ofSize: 18.0)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.text
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        lbl.textAlignment = .center
        return lbl
    }()

    init(num: String, title: String) {
        super.init(frame: .zero)
        buildUI()
        lblNum.text = num
        lblTitle.text = title
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func buildUI() {
        axis = .vertical
        distribution = .fill
        alignment = .center
        spacing = 4

        addArrangedSubview(lblNum)
        addArrangedSubview(lblTitle)
    }

}

