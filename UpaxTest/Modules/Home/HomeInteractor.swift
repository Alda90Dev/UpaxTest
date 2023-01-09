//
//  HomeInteractor.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation

/////////////////////// HOME INTERACTOR PROTOCOLS
protocol HomeInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(receivedData: NetworkResult<ProductResponse>)
}

protocol HomeInteractorInputProtocol {
    var presenter: HomeInteractorOutputProtocol? { get set }
    func getProducts(typeService: NetworkRouter)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// HOME INTERACTOR
///////////////////////////////////////////////////////////////////////////////////////////////////

class HomeInteractor: HomeInteractorInputProtocol {
    
    weak var presenter: HomeInteractorOutputProtocol?
    
    func getProducts(typeService: NetworkRouter) {
        NetworkManager.shared.request(networkRouter: typeService) { [weak self] (result: NetworkResult<ProductResponse>) in
            self?.presenter?.interactorGetDataPresenter(receivedData: result)
        }
    }
    
}
