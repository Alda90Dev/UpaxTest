//
//  SplashView.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import UIKit

protocol SplashViewProtocol: AnyObject {
    var presenter: SplashPresenterProtocol? { get set }
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// OPTIONS VIEW
///////////////////////////////////////////////////////////////////////////////////////////////////

class SplashView: UIViewController {
    var presenter: SplashPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorCatalog.principal
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.presenter?.navigate()
        })
    }
    
}

extension SplashView: SplashViewProtocol { }
