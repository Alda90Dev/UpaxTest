//
//  HomeView.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import UIKit

/////////////////////// HOME VIEW PROTOCOL
protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    
    func getDataProducts(products: String?)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// HOME VIEW
///////////////////////////////////////////////////////////////////////////////////////////////////
class HomeView: UIViewController {
    var presenter: HomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

}
private extension HomeView {
    
    func setupView() {
        title = "Home"
        view.backgroundColor = .white
    }
    
}

extension HomeView: HomeViewProtocol {
    func getDataProducts(products: String?) {
        
    }
    
    
}
