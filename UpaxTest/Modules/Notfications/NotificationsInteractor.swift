//
//  NotificationsInteractor.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation

/////////////////////// NOTIFICATIONS INTERACTOR PROTOCOLS
protocol NotificationsInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(receivedData: NetworkResult<PostResponse>)
}

protocol NotificationsInteractorInputProtocol {
    var presenter: NotificationsInteractorOutputProtocol? { get set }
    func getNotifications(typeService: NetworkRouter)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// NOTIFICATIONS INTERACTOR
///////////////////////////////////////////////////////////////////////////////////////////////////

class NotificationsInteractor: NotificationsInteractorInputProtocol {
    
    weak var presenter: NotificationsInteractorOutputProtocol?
    
    func getNotifications(typeService: NetworkRouter) {
        NetworkManager.shared.request(networkRouter: typeService) { [weak self] (result: NetworkResult<PostResponse>) in
            self?.presenter?.interactorGetDataPresenter(receivedData: result)
        }
    }
    
}
