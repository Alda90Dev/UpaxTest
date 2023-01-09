//
//  HomeRouter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import Foundation
import UIKit

/////////////////////// HOME ROUTER  PROTOCOL
protocol HomeRouterProtocol {
    var presenter: HomePresenterProtocol? { get set }
    static func createHomeModule() -> UIViewController
}


////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// HOME ROUTER
///////////////////////////////////////////////////////////////////////////////////////////////////
class HomeRouter: HomeRouterProtocol {
    
    var presenter: HomePresenterProtocol?
    
    static func createHomeModule() -> UIViewController {
        let view = HomeView()

        let interactor = HomeInteractor()
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let router = HomeRouter()

        router.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
}
