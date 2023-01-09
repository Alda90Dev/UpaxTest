//
//  NotificationsRouter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation
import UIKit

/////////////////////// NOTIFICATIONS ROUTER  PROTOCOL
protocol NotificationsRouterProtocol {
    var presenter: NotificationsPresenterProtocol? { get set }
    static func createNotificationsModule() -> UIViewController
}


////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// NOTIFICATIONS ROUTER
///////////////////////////////////////////////////////////////////////////////////////////////////
class NotificationsRouter: NotificationsRouterProtocol {
    
    var presenter: NotificationsPresenterProtocol?
    
    static func createNotificationsModule() -> UIViewController {
        let view = NotificationsView()

        let interactor = NotificationsInteractor()
        let presenter: NotificationsPresenterProtocol & NotificationsInteractorOutputProtocol = NotificationsPresenter()
        let router = NotificationsRouter()

        router.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
}
