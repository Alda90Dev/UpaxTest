//
//  InboxInterceptos.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import Foundation

/////////////////////// INBOX INTERACTOR PROTOCOLS
protocol InboxInteractorOutputProtocol: AnyObject {
    func interactorGetDataPresenter(receivedData: NetworkResult<CommentResponse>)
}

protocol InboxInteractorInputProtocol {
    var presenter: InboxInteractorOutputProtocol? { get set }
    func getInbox(typeService: NetworkRouter)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// INBOX INTERACTOR
///////////////////////////////////////////////////////////////////////////////////////////////////

class InboxInteractor: InboxInteractorInputProtocol {
    
    weak var presenter: InboxInteractorOutputProtocol?
    
    func getInbox(typeService: NetworkRouter) {
        NetworkManager.shared.request(networkRouter: typeService) { [weak self] (result: NetworkResult<CommentResponse>) in
            self?.presenter?.interactorGetDataPresenter(receivedData: result)
        }
    }
    
}
