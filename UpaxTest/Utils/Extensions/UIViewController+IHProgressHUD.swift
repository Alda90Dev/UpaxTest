//
//  UIViewController+IHProgressHUD.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import UIKit
import IHProgressHUD

extension UIViewController {
    
    func showIndicator(withTitle title: String = Content.loading) {
        IHProgressHUD.show(withStatus: title)
    }
    
    func hideIndicator() {
        IHProgressHUD.dismiss()
    }
}

