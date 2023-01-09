//
//  ProfileInteractor.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation

/////////////////////// PROFILE INTERACTOR PROTOCOLS
protocol ProfileInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(receivedData: NetworkResult<ProductResponse>)
}

protocol ProfileInteractorInputProtocol {
    var presenter: ProfileInteractorOutputProtocol? { get set }
    func getProducts(typeService: NetworkRouter)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// PROFILE INTERACTOR
///////////////////////////////////////////////////////////////////////////////////////////////////

class ProfileInteractor: ProfileInteractorInputProtocol {
    
    weak var presenter: ProfileInteractorOutputProtocol?
    
    func getProducts(typeService: NetworkRouter) {
        NetworkManager.shared.request(networkRouter: typeService) { [weak self] (result: NetworkResult<ProductResponse>) in
            self?.presenter?.interactorGetDataPresenter(receivedData: result)
        }
    }
    
}
