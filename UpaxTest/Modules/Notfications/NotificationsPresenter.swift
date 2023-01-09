//
//  NotificationsPresenter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation

/////////////////////// NOTIFICATIONS PRESENTER PROTOCOL
protocol NotificationsPresenterProtocol: AnyObject {
    var view: NotificationsViewProtocol? { get set }
    var interactor: NotificationsInteractorInputProtocol? { get set }
    var router: NotificationsRouterProtocol? { get set }
    
    func getNotifications()
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// NOTIFICATIONS PRESENTER
///////////////////////////////////////////////////////////////////////////////////////////////////

class NotificationsPresenter: NotificationsPresenterProtocol {
    
    weak var view: NotificationsViewProtocol?
    var interactor: NotificationsInteractorInputProtocol?
    var router: NotificationsRouterProtocol?
    
    func getNotifications() {
        interactor?.getNotifications(typeService: NetworkRouter.getPosts)
    }

}

extension NotificationsPresenter: NotificationsInteractorOutputProtocol {
    
    func interactorGetDataPresenter(receivedData: NetworkResult<PostResponse>) {
        switch receivedData {
        case .success(let data):
            view?.getDataNotifications(posts: data.posts)
        case .failure(let error):
            view?.dataError(error: error)
        }
    }
    
}
