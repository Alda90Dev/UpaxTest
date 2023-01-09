//
//  TabBarRouter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation
import UIKit

/////////////////////// TABBAR ROUTER  PROTOCOL
protocol TabBarRouterProtocol {
    static func createTabBarModule() -> UIViewController
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// TABBAR ROUTER
///////////////////////////////////////////////////////////////////////////////////////////////////
///

class TabBarRouter: TabBarRouterProtocol {
    
    static func createTabBarModule() -> UIViewController {
        
        let view = TabBarView()
        let presenter: TabBarPresenterProtocol = TabBarPresenter()
        let router = TabBarRouter()
        
        presenter.router = router
        view.presenter = presenter
        presenter.view = view

        return view
    }
}

