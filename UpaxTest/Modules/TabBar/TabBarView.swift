//
//  TabBarView.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import UIKit

protocol TabBarViewProtocol: AnyObject {
    var presenter: TabBarPresenterProtocol? { get set }
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// TABBAR VIEW
///////////////////////////////////////////////////////////////////////////////////////////////////

class TabBarView: UITabBarController {

    var presenter: TabBarPresenterProtocol?
    var upperLineView: UIView!
    let spacing: CGFloat = 12

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        delegate = self

        let homeView = HomeRouter.createHomeModule()
        homeView.tabBarItem = UITabBarItem(title: nil, image: ImageCatalog.iconHome, tag: 1)
        let nav1 = UINavigationController(rootViewController: homeView)

        let inboxView = InboxRouter.createInboxModule()
        inboxView.tabBarItem =  UITabBarItem(title: nil, image: ImageCatalog.iconMessages, tag: 2)
        let nav2 = UINavigationController(rootViewController: inboxView)

        let controller3 = UIViewController()
        let nav3 = UINavigationController(rootViewController: controller3)
        nav3.title = ""

        let notificationsView = NotificationsRouter.createNotificationsModule()
        notificationsView.tabBarItem = UITabBarItem(title: nil, image: ImageCatalog.iconNotifications, tag: 4)
        let nav4 = UINavigationController(rootViewController: notificationsView)

        let controller5 = UIViewController()
        controller5.tabBarItem = UITabBarItem(title: nil, image: ImageCatalog.iconProfile, tag: 5)
        let nav5 = UINavigationController(rootViewController: controller5)

        viewControllers = [nav1, nav2, nav3, nav4, nav5]
        
        setupMiddleButton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.addTabbarIndicatorView(index: 0, isFirstTime: true)
        }
    
    }
    
    override func viewDidLayoutSubviews() {
        setupTabBar()
    }
    
    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 2
        addTabbarIndicatorView(index: self.selectedIndex)
    }
    
}

private extension TabBarView {
    
    func setupTabBar() {
        var tabFrame = tabBar.frame
        tabFrame.size.height = 55 + tabBar.safeAreaBottom
        tabFrame.origin.y = tabBar.frame.origin.y + tabBar.frame.height - 55 - tabBar.safeAreaBottom

        tabBar.backgroundColor = .white
        tabBar.tintColor = ColorCatalog.dark
        tabBar.layer.cornerRadius = 18
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2);
        tabBar.layer.shadowOpacity = 0.21
        tabBar.layer.shadowRadius = 8
        tabBar.frame = tabFrame
        tabBar.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -3.0) })

    }
    
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - (tabBar.frame.size.height / 2)
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame

        menuButton.backgroundColor = ColorCatalog.principal
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)

        menuButton.setImage(ImageCatalog.iconPlus, for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

        view.layoutIfNeeded()
    }
    
    ///Add tabbar item indicator uper line
    func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false){
        guard let tabView = tabBar.items?[index].value(forKey: Content.K.view) as? UIView else {
            return
        }
        
        if !isFirstTime {
            upperLineView.removeFromSuperview()
        }
        
        upperLineView = UIView(frame: CGRect(x: tabView.frame.minX + spacing, y: tabView.frame.minY + 0.1, width: tabView.frame.size.width - spacing * 2, height: 4))
        upperLineView.backgroundColor = ColorCatalog.principal
        tabBar.addSubview(upperLineView)
    }
}

extension TabBarView: TabBarViewProtocol { }

extension TabBarView: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        addTabbarIndicatorView(index: self.selectedIndex)
    }
}
