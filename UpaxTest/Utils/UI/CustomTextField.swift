//
//  CustomTextField.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 07/01/23.
//

import UIKit

class CustomTextField: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 20,
        bottom: 10,
        right: 20
    )
    
    var placeholderText: String? {
        didSet {
            let placeholderTextColor = NSAttributedString(string: placeholderText ?? "",
                                                          attributes: [NSAttributedString.Key.foregroundColor: ColorCatalog.placeholder])
            
            attributedPlaceholder = placeholderTextColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white.withAlphaComponent(0.9)
        borderStyle = .none
        textColor = ColorCatalog.text
        autocapitalizationType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    func addLineLayer() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
        bottomLine.backgroundColor = ColorCatalog.principal.cgColor
        layer.addSublayer(bottomLine)
    }
}
