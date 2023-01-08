//
//  LoginInteractor.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 07/01/23.
//

import Foundation
/////////////////////// LOGIN INTERACTOR PROTOCOLS
protocol LoginInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(receivedData: String?, error: Error?)
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
        
        firebase.signIn(email: user, password: password)
    }
    
    private func loginError(error: Error) {
        presenter?.interactorGetDataPresenter(receivedData: nil, error: error)
    }
    
}
