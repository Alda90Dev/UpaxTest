//
//  ChartsRouter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation
import UIKit

/////////////////////// CHARTS ROUTER  PROTOCOL
protocol ChartsRouterProtocol {
    var presenter: ChartsPresenterProtocol? { get set }
    static func createChartsModule() -> UIViewController
}


////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// CHARTS ROUTER
///////////////////////////////////////////////////////////////////////////////////////////////////
class ChartsRouter: ChartsRouterProtocol {
    
    var presenter: ChartsPresenterProtocol?
    
    static func createChartsModule() -> UIViewController {
        let view = ChartsView()

        let interactor = ChartsInteractor()
        let presenter: ChartsPresenterProtocol & ChartsInteractorOutputProtocol = ChartsPresenter()
        let router = ChartsRouter()

        router.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
}
