//
//  LoginPresenter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 07/01/23.
//

import Foundation
import Combine

/////////////////////// LOGIN PRESENTER PROTOCOL
protocol LoginPresenterProtocol: AnyObject {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    
    func tapToLogin(input: (String, String))
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// LOGIN PRESENTER
///////////////////////////////////////////////////////////////////////////////////////////////////

class LoginPresenter: LoginPresenterProtocol {
   
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var router: LoginRouterProtocol?
    
    
    func tapToLogin(input: (String, String)) {
        interactor?.login(user: input.0, password: input.1)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    
    func interactorGetDataPresenter(receivedData: String?, error: Error?) {
        view?.loginDataError(error: error)
        if let response = receivedData {
            router?.goToHome(from: view!)
        }
    }
    
}
