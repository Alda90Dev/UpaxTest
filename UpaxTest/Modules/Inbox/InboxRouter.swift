//
//  InboxRouter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation
import UIKit

/////////////////////// INBOX ROUTER  PROTOCOL
protocol InboxRouterProtocol {
    var presenter: InboxPresenterProtocol? { get set }
    static func createInboxModule() -> UIViewController
}


////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// INBOX ROUTER
///////////////////////////////////////////////////////////////////////////////////////////////////
class InboxRouter: InboxRouterProtocol {
    
    var presenter: InboxPresenterProtocol?
    
    static func createInboxModule() -> UIViewController {
        let view = InboxView()

        let interactor = InboxInteractor()
        let presenter: InboxPresenterProtocol & InboxInteractorOutputProtocol = InboxPresenter()
        let router = InboxRouter()

        router.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
}
