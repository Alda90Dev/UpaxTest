//
//  ProfilePresenter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation

/////////////////////// PROFILE PRESENTER PROTOCOL
protocol ProfilePresenterProtocol: AnyObject {
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var router: ProfileRouterProtocol? { get set }
    
    func getProducts()
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// PROFILE PRESENTER
///////////////////////////////////////////////////////////////////////////////////////////////////

class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var router: ProfileRouterProtocol?
    
    func getProducts() {
        interactor?.getProducts(typeService: NetworkRouter.getProducts)
    }

}

extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
    func interactorGetDataPresenter(receivedData: NetworkResult<ProductResponse>) {
        switch receivedData {
        case .success(let data):
            view?.getDataProducts(products: data.products)
        case .failure(let error):
            view?.dataError(error: error)
        }
    }
    
}
