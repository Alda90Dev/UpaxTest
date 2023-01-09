//
//  InboxView.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import UIKit

/////////////////////// INBOX VIEW PROTOCOL
protocol InboxViewProtocol: AnyObject {
    var presenter: InboxPresenterProtocol? { get set }
    
    func getDataInbox(comments: [Comment])
    func dataError(error: Error)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// INBOX VIEW
///////////////////////////////////////////////////////////////////////////////////////////////////
class InboxView: UIViewController {
    var presenter: InboxPresenterProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView =  UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ColorCatalog.backgroundTab
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var comments: [Comment]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.getInbox()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = Content.tab.inbox
    }

}
private extension InboxView {
    
    func setupView() {
        
        let rightBarButtonItem = UIBarButtonItem(image: ImageCatalog.search, style: .plain, target: self, action: #selector(didTapSearch))
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

extension InboxView: InboxViewProtocol {
    func getDataInbox(comments: [Comment]) {
        self.comments = comments
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func dataError(error: Error) {
        self.presentAlert(Content.errorMessage, message: error.localizedDescription)
    }
}

extension InboxView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let comments = comments else { return 0 }

        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let comments = comments else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseIdentifier, for: indexPath) as! CommentCell
        cell.configure(comment: comments[indexPath.row])
        cell.layoutIfNeeded()
        return cell
    }
}

extension InboxView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
}
