//
//  ChartsInteractor.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation

/////////////////////// CHARTS INTERACTOR PROTOCOLS
protocol ChartsInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(receivedData: NetworkResult<DataResponse>)
}

protocol ChartsInteractorInputProtocol {
    var presenter: ChartsInteractorOutputProtocol? { get set }
    func getProducts(typeService: NetworkRouter)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// CHARTS INTERACTOR
///////////////////////////////////////////////////////////////////////////////////////////////////

class ChartsInteractor: ChartsInteractorInputProtocol {
    
    weak var presenter: ChartsInteractorOutputProtocol?
    
    func getProducts(typeService: NetworkRouter) {
        NetworkManager.shared.request(networkRouter: typeService) { [weak self] (result: NetworkResult<DataResponse>) in
            self?.presenter?.interactorGetDataPresenter(receivedData: result)
        }
    }
    
}
