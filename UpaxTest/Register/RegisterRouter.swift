//
//  RegisterRouter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation
import UIKit

/////////////////////// REGISTER ROUTER  PROTOCOL
protocol RegisterRouterProtocol {
    var presenter: RegisterPresenterProtocol? { get set }
    static func createRegisterModule() -> UIViewController
    func goToHome(from view: RegisterViewProtocol)
    func goToLogin(from view: RegisterViewProtocol)
}


////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// REGISTER ROUTER
///////////////////////////////////////////////////////////////////////////////////////////////////
class RegisterRouter: RegisterRouterProtocol {
    
    var presenter: RegisterPresenterProtocol?
    
    static func createRegisterModule() -> UIViewController {
        
        let view = RegisterView()

        let interactor = RegisterInteractor()
        let presenter: RegisterPresenterProtocol & RegisterInteractorOutputProtocol = RegisterPresenter()
        let router = RegisterRouter()

        router.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func goToHome(from view: RegisterViewProtocol) {
       
    }
    
    func goToLogin(from view: RegisterViewProtocol) {
        
    }
}
