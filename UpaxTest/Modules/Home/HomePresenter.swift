//
//  HomePresenter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation
/////////////////////// HOME PRESENTER PROTOCOL
protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func getProducts()
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// HOME PRESENTER
///////////////////////////////////////////////////////////////////////////////////////////////////

class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
    
    func getProducts() {
        interactor?.getProducts(typeService: NetworkRouter.getProducts)
    }

}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func interactorGetDataPresenter(receivedData: NetworkResult<ProductResponse>) {
        switch receivedData {
        case .success(let data):
            view?.getDataProducts(products: data.products)
        case .failure(let error):
            view?.dataError(error: error)
        }
    }
    
}
