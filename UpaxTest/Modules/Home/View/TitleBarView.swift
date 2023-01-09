//
//  TitleBar.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import UIKit

final class TitleBarView: UIView {

    override init (frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setup(_ title: String, subtitle: String) {
        let titleLabel = UILabel(frame: CGRectMake(0, -16, 0, 0))

        titleLabel.backgroundColor = .clear
        titleLabel.textColor = ColorCatalog.dark
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.text = title
        titleLabel.sizeToFit()

        let subtitleLabel = UILabel(frame: CGRectMake(0, 5, 0, 0))
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.textColor = ColorCatalog.placeholder
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()

        let titleView = UIView(frame: CGRectMake(0, 0, max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)

        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width

        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }
        
        addSubview(titleView)
    }
}

