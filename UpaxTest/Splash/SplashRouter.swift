//
//  SplashRouter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation
import UIKit

/////////////////////// SPLASH ROUTER  PROTOCOL
protocol SplashRouterProtocol {
    static func createSplashModule() -> UIViewController
    func goTo(from view: SplashViewProtocol)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// SPLASH ROUTER
///////////////////////////////////////////////////////////////////////////////////////////////////
///

class SplashRouter: SplashRouterProtocol {
    
    static func createSplashModule() -> UIViewController {
        
        let view = SplashView()
        let presenter: SplashPresenterProtocol = SplashPresenter()
        let router = SplashRouter()
        
        presenter.router = router
        view.presenter = presenter
        presenter.view = view

        return view
    }
    
    func goTo(from view: SplashViewProtocol) {
        validateUser(from: view)
    }
}

private extension SplashRouter {
    
    func validateUser(from view: SplashViewProtocol) {
        debugPrint( Defaults.shared.email)
        Defaults.shared.email.isEmpty ? goToLogin(from: view) : goToHome(from: view)
    }

    func goToLogin(from view: SplashViewProtocol) {
        if let vc = view as? UIViewController {
            let loginView = LoginRouter.createLoginModule()
            let navVC = UINavigationController(rootViewController: loginView)
            navVC.modalTransitionStyle = .crossDissolve
            navVC.modalPresentationStyle = .fullScreen
            vc.present(navVC, animated: true)
        }
    }
    
    func goToHome(from view: SplashViewProtocol) {
        if let vc = view as? UIViewController {
            let homeView = HomeView()
            let navVC = UINavigationController(rootViewController: homeView)
            navVC.modalTransitionStyle = .crossDissolve
            navVC.modalPresentationStyle = .fullScreen
            vc.present(navVC, animated: true)
        }
    }
    
}
