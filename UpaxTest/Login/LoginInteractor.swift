//
//  LoginInteractor.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 07/01/23.
//

import Foundation
import FirebaseAuth

/////////////////////// LOGIN INTERACTOR PROTOCOLS
protocol LoginInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(result: NetworkResult<User>)
}

protocol LoginInteractorInputProtocol {
    var presenter: LoginInteractorOutputProtocol? { get set }
    func login(user: String, password: String)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// LOGIN INTERACTOR
///////////////////////////////////////////////////////////////////////////////////////////////////

class LoginInteractor: LoginInteractorInputProtocol {
    
    weak var presenter: LoginInteractorOutputProtocol?
    private var user: String?
    
    func login(user: String, password: String) {
        let firebase = FirebaseManager.shared
        
        firebase.signIn(email: user, password: password) { [weak self] (result: NetworkResult<User>) in
            self?.presenter?.interactorGetDataPresenter(result: result)
        }
    }
    
}
