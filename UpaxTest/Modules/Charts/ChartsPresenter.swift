//
//  ChartsPresenter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation

/////////////////////// CHARTS PRESENTER PROTOCOL
protocol ChartsPresenterProtocol: AnyObject {
    var view: ChartsViewProtocol? { get set }
    var interactor: ChartsInteractorInputProtocol? { get set }
    var router: ChartsRouterProtocol? { get set }
    
    func getProducts()
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// CHARTS PRESENTER
///////////////////////////////////////////////////////////////////////////////////////////////////

class ChartsPresenter: ChartsPresenterProtocol {
    
    weak var view: ChartsViewProtocol?
    var interactor: ChartsInteractorInputProtocol?
    var router: ChartsRouterProtocol?
    
    func getProducts() {
        interactor?.getProducts(typeService: NetworkRouter.getData)
    }

}

extension ChartsPresenter: ChartsInteractorOutputProtocol {
    
    func interactorGetDataPresenter(receivedData: NetworkResult<DataResponse>) {
        switch receivedData {
        case .success(let data):
            view?.getDataProducts(data: data.data)
        case .failure(let error):
            view?.dataError(error: error)
        }
    }
    
}
