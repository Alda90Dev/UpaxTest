//
//  LoginPresenter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 07/01/23.
//

import Foundation
import FirebaseAuth

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
    func interactorGetDataPresenter(result: NetworkResult<User>) {
        switch result {
        case .success(let data):
            router?.goToHome(from: view!)
            break
        case .failure(let error):
            view?.loginDataError(error: error)
        }
    }
}
