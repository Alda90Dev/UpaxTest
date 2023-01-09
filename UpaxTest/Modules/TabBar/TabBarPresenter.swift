//
//  TabBarPresenter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation
/////////////////////// TABBAR PRESENTER PROTOCOL
protocol TabBarPresenterProtocol: AnyObject {
    var view: TabBarViewProtocol? { get set }
    var router: TabBarRouterProtocol? { get set }
    
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// TABBAR  PRESENTER
///////////////////////////////////////////////////////////////////////////////////////////////////

class TabBarPresenter {
    weak var view: TabBarViewProtocol?
    var router: TabBarRouterProtocol?
}

extension TabBarPresenter: TabBarPresenterProtocol { }
