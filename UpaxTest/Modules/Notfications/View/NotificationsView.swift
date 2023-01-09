//
//  NotificationsView.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import UIKit

/////////////////////// NOTIFICATIONS VIEW PROTOCOL
protocol NotificationsViewProtocol: AnyObject {
    var presenter: NotificationsPresenterProtocol? { get set }
    
    func getDataNotifications(posts: [Post])
    func dataError(error: Error)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// NOTIFICATIONS VIEW
///////////////////////////////////////////////////////////////////////////////////////////////////
class NotificationsView: UIViewController {
    var presenter: NotificationsPresenterProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView =  UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ColorCatalog.backgroundTab
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var posts: [Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.getNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = Content.tab.notifications
    }

}
private extension NotificationsView {
    
    func setupView() {
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
}

extension NotificationsView: NotificationsViewProtocol {
    func getDataNotifications(posts: [Post]) {
        self.posts = posts
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func dataError(error: Error) {
        self.presentAlert(Content.errorMessage, message: error.localizedDescription)
    }
}

extension NotificationsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let posts = posts else { return 0 }

        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let posts = posts else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath) as! PostCell
        cell.configure(post: posts[indexPath.row])
        cell.layoutIfNeeded()
        return cell
    }
}

extension NotificationsView
: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
}

