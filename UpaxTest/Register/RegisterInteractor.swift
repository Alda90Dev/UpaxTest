//
//  RegisterInteractor.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation
import FirebaseAuth

/////////////////////// REGISTER INTERACTOR PROTOCOLS
protocol RegisterInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(result: NetworkResult<User>)
}

protocol RegisterInteractorInputProtocol {
    var presenter: RegisterInteractorOutputProtocol? { get set }
    func register(name: String, email: String, password: String)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// REGISTER  INTERACTOR
///////////////////////////////////////////////////////////////////////////////////////////////////

class RegisterInteractor: RegisterInteractorInputProtocol {
    
    weak var presenter: RegisterInteractorOutputProtocol?
    private let firebase = FirebaseManager.shared
    
    func register(name: String, email: String, password: String) {
        
        firebase.createUser(email: email, password: password) { [weak self] (result: NetworkResult<User>) in
            switch result {
            case .success:
                self?.updateUser(name: name, resultRegister: result)
            case .failure:
                self?.presenter?.interactorGetDataPresenter(result: result)
            }
            
        }
    }
    
}

private extension RegisterInteractor {
    func updateUser(name: String, resultRegister: NetworkResult<User>) {
        firebase.updateUser(name: name) { [weak self]  (result: Error?) in
            if let error = result {
                self?.presenter?.interactorGetDataPresenter(result: NetworkResult.failure(error: NetworkErrorType.customizedError(message: error.localizedDescription)))
            }
            
            self?.presenter?.interactorGetDataPresenter(result: resultRegister)
        }
    }
}
