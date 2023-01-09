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
    func register(profile: Profile)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// REGISTER  INTERACTOR
///////////////////////////////////////////////////////////////////////////////////////////////////

class RegisterInteractor: RegisterInteractorInputProtocol {
    
    weak var presenter: RegisterInteractorOutputProtocol?
    private let firebase = FirebaseManager.shared
    private var resultRegister: NetworkResult<User>?
    private var profile: Profile?
    
    func register(profile: Profile) {
        self.profile = profile
        firebase.createUser(email: profile.email, password: profile.password) { [weak self] (result: NetworkResult<User>) in
            switch result {
            case .success:
                self?.resultRegister = result
                self?.updateUser()
            case .failure:
                self?.presenter?.interactorGetDataPresenter(result: result)
            }
        }
    }
    
}

private extension RegisterInteractor {
    func updateUser() {
        guard let profile = profile else { return }
        
        firebase.updateUser(name: profile.name) { [weak self]  (result: Error?) in
            if let error = result {
                self?.presenter?.interactorGetDataPresenter(result: NetworkResult.failure(error: NetworkErrorType.customizedError(message: error.localizedDescription)))
            }
            
            self?.uploadImage()
        }
    }
    
    func uploadImage() {
        guard let profile = profile,
              let resultRegister = resultRegister else { return }
        
        guard let imageData = profile.image else {
            presenter?.interactorGetDataPresenter(result: resultRegister)
            return
        }
        
        firebase.uploadImage(name: profile.name, imageData: imageData) { [weak self]  (result: Error?) in
            if let error = result {
                self?.presenter?.interactorGetDataPresenter(result: NetworkResult.failure(error: NetworkErrorType.customizedError(message: error.localizedDescription)))
            }
            
            self?.getImageUrl()
        }
    }
    
    func getImageUrl() {
        guard let profile = profile,
              let resultRegister = resultRegister else { return }
        firebase.getImage(name: profile.name) { [weak self] (result: NetworkResult<String>) in
            switch result {
            case .success(let url):
                Defaults.shared.avatar = url
                self?.presenter?.interactorGetDataPresenter(result: resultRegister)
            case .failure(let error):
                self?.presenter?.interactorGetDataPresenter(result: NetworkResult.failure(error: NetworkErrorType.customizedError(message: error.localizedDescription)))
            }
        }
    }
}
