//
//  ProfileView.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 09/01/23.
//

import UIKit
import SDWebImage
import ScrollableSegmentedControl

/////////////////////// PROFILE VIEW PROTOCOL
protocol ProfileViewProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    
    func getDataProducts(products: [Product])
    func dataError(error: Error)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// PROFILE VIEW
///////////////////////////////////////////////////////////////////////////////////////////////////
class ProfileView: UIViewController {
    
    private lazy var imgUser: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = ImageCatalog.placeholderUser
        return image
    }()
    
    private lazy var lblName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.dark
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var lblEmail: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.text
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var firstStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 4
        return stack
    }()
    
    private lazy var lblNumPosts: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.dark
        lbl.font = UIFont.systemFont(ofSize: 18.0)
        lbl.textAlignment = .center
        lbl.text = "21"
        return lbl
    }()
    
    private lazy var lblPost: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.text
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        lbl.textAlignment = .center
        lbl.text = "Posts"
        return lbl
    }()
    
    private lazy var secondStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 4
        return stack
    }()
    
    private lazy var lblNumFollowers: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.dark
        lbl.font = UIFont.systemFont(ofSize: 18.0)
        lbl.textAlignment = .center
        lbl.text = "981"
        return lbl
    }()
    
    private lazy var lblFollowers: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.text
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        lbl.textAlignment = .center
        lbl.text = "Followers"
        return lbl
    }()
    
    private lazy var thirdStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 4
        return stack
    }()
    
    private lazy var lblNumFollowing: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.dark
        lbl.font = UIFont.systemFont(ofSize: 18.0)
        lbl.textAlignment = .center
        lbl.text = "63"
        return lbl
    }()
    
    private lazy var lblFollowing: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = ColorCatalog.text
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        lbl.textAlignment = .center
        lbl.text = "Following"
        return lbl
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 12
        return stack
    }()
    
    private lazy var segmentedControl: ScrollableSegmentedControl = {
        let segmented = ScrollableSegmentedControl()
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.segmentStyle = .textOnly
        segmented.underlineSelected = true
        segmented.segmentContentColor = ColorCatalog.placeholder
        segmented.selectedSegmentContentColor = ColorCatalog.principal
        segmented.backgroundColor = .white
        segmented.selectedSegmentIndex = 0
        segmented.tintColor = ColorCatalog.principal
        segmented.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        return segmented
    }()
    
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
    
    var presenter: ProfilePresenterProtocol?
    
    private var products: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        presenter?.getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        imgUser.layer.cornerRadius = imgUser.frame.size.width / 2
    }

}

private extension ProfileView {
    
    func setupView() {
        view.backgroundColor = .white
        
        segmentedControl.insertSegment(withTitle: Content.tab.posts, at: 0)
        segmentedControl.insertSegment(withTitle: Content.tab.liked, at: 1)
        
        firstStackView.addArrangedSubview(lblNumPosts)
        firstStackView.addArrangedSubview(lblPost)
        
        secondStackView.addArrangedSubview(lblNumFollowers)
        secondStackView.addArrangedSubview(lblFollowers)
        
        thirdStackView.addArrangedSubview(lblNumFollowing)
        thirdStackView.addArrangedSubview(lblFollowing)
        
        stackView.addArrangedSubview(firstStackView)
        stackView.addArrangedSubview(secondStackView)
        stackView.addArrangedSubview(thirdStackView)
        
        view.addSubview(imgUser)
        view.addSubview(lblName)
        view.addSubview(lblEmail)
        view.addSubview(stackView)
        view.addSubview(segmentedControl)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            imgUser.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            imgUser.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgUser.widthAnchor.constraint(equalToConstant: 160),
            imgUser.heightAnchor.constraint(equalToConstant: 160),
            
            lblName.topAnchor.constraint(equalTo: imgUser.bottomAnchor, constant: 16),
            lblName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lblName.heightAnchor.constraint(equalToConstant: 35),
            
            lblEmail.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 0),
            lblEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lblEmail.heightAnchor.constraint(equalToConstant: 30),
            
            stackView.topAnchor.constraint(equalTo: lblEmail.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 44),
            
            segmentedControl.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
    }
    
    func setupData() {
        let url = URL(string: Defaults.shared.avatar)
        imgUser.sd_setImage(with: url, placeholderImage: ImageCatalog.placeholderUser)
        
        lblName.text = Defaults.shared.name
        lblEmail.text = Defaults.shared.email
        
        segmentedControl.selectedSegmentIndex = 0
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
    
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        debugPrint("Segment at index \(sender.selectedSegmentIndex)  selected")
    }
}

extension ProfileView: ProfileViewProtocol {
    
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

extension ProfileView: UITableViewDataSource {
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

extension ProfileView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
}
