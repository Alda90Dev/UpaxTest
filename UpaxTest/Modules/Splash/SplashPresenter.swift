//
//  SplashPresenter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation

/////////////////////// SPLASH PRESENTER PROTOCOL
protocol SplashPresenterProtocol: AnyObject {
    var view: SplashViewProtocol? { get set }
    var router: SplashRouterProtocol? { get set }
    
    func navigate()
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// SPLASH  PRESENTER
///////////////////////////////////////////////////////////////////////////////////////////////////

class SplashPresenter {
    weak var view: SplashViewProtocol?
    var router: SplashRouterProtocol?
}

extension SplashPresenter: SplashPresenterProtocol {
    func navigate() {
        router?.goTo(from: view!)
    }
}
