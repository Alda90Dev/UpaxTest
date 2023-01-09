//
//  InboxPresenter.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation

/////////////////////// INBOX PRESENTER PROTOCOL
protocol InboxPresenterProtocol: AnyObject {
    var view: InboxViewProtocol? { get set }
    var interactor: InboxInteractorInputProtocol? { get set }
    var router: InboxRouterProtocol? { get set }
    
    func getInbox()
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// INBOX PRESENTER
///////////////////////////////////////////////////////////////////////////////////////////////////

class InboxPresenter: InboxPresenterProtocol {
    
    weak var view: InboxViewProtocol?
    var interactor: InboxInteractorInputProtocol?
    var router: InboxRouterProtocol?
    
    func getInbox() {
        interactor?.getInbox(typeService: NetworkRouter.getComments)
    }

}

extension InboxPresenter: InboxInteractorOutputProtocol {
    
    func interactorGetDataPresenter(receivedData: NetworkResult<CommentResponse>) {
        switch receivedData {
        case .success(let data):
            view?.getDataInbox(comments: data.comments)
        case .failure(let error):
            view?.dataError(error: error)
        }
    }
    
}
