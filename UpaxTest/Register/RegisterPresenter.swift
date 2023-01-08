//
//  RegisterPresenter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation
import FirebaseAuth

/////////////////////// REGISTER PRESENTER PROTOCOL
protocol RegisterPresenterProtocol: AnyObject {
    var view: RegisterViewProtocol? { get set }
    var interactor: RegisterInteractorInputProtocol? { get set }
    var router: RegisterRouterProtocol? { get set }
    
    func tapToRegister(input: (String, String, String, Data?))
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// REGISTER  PRESENTER
///////////////////////////////////////////////////////////////////////////////////////////////////

class RegisterPresenter: RegisterPresenterProtocol {
   
    weak var view: RegisterViewProtocol?
    var interactor: RegisterInteractorInputProtocol?
    var router: RegisterRouterProtocol?
    
    
    func tapToRegister(input: (String, String, String, Data?)) {
        let profile = Profile(name: input.0, email: input.1, password: input.2, image: input.3)
        interactor?.register(profile: profile)
    }
}

extension RegisterPresenter: RegisterInteractorOutputProtocol {
    func interactorGetDataPresenter(result: NetworkResult<User>) {
        switch result {
        case .success(let data):
            router?.goToHome(from: view!)
            break
        case .failure(let error):
            view?.registerDataError(error: error)
        }
    }
}
