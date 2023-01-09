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
    
    func getDataProducts(products: [Product])
    func dataError(error: Error)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// HOME VIEW
///////////////////////////////////////////////////////////////////////////////////////////////////
class HomeView: UIViewController {
    var presenter: HomePresenterProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView =  UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ColorCatalog.backgroundTab
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var products: [Product]?
    
    var controladorDeBusca: UISearchController!
    
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
        let titleView = TitleBarView()
        titleView.setup(Content.allCategories, subtitle: Content.place)
        let leftBarButtonItem = UIBarButtonItem(customView: titleView)
        
        let rightBarButtonItem = UIBarButtonItem(image: ImageCatalog.search, style: .plain, target: self, action: #selector(didTapSearch))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func presentAlert(_ title: String, message: String) {
        self.openAlert(title: title,
                       message: message,
                       alertStyle: .alert,
                       actionTitles: [Content.alert.okMessage],
                       actionStyles: [.default],
                       actions: [ {_ in
            print(Content.alert.okMessage)
        },])
    }
    
    @objc func didTapSearch() {
    }
}


extension HomeView: HomeViewProtocol {
    
    func getDataProducts(products: [Product]) {
        self.products = products
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func dataError(error: Error) {
        self.presentAlert(Content.errorMessage, message: error.localizedDescription)
    }
}

extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let products = products else { return 0 }
        
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let products = products else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIdentifier, for: indexPath) as! ProductCell
        cell.configure(product: products[indexPath.row])
        cell.layoutIfNeeded()
        return cell
    }
}

extension HomeView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
}
