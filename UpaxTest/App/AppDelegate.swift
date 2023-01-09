//
//  AppDelegate.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 07/01/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [ NSAttributedString.Key.foregroundColor : ColorCatalog.dark ]
            
            navigationBarAppearance.backgroundColor = .white
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
                    
            let tabBarApperance = UITabBarAppearance()
            tabBarApperance.configureWithOpaqueBackground()
            tabBarApperance.backgroundColor = .white
            UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
            UITabBar.appearance().standardAppearance = tabBarApperance
            
        } else {
            UINavigationBar.appearance().isOpaque = true
            
            UINavigationBar.appearance().backgroundColor = .white
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorCatalog.dark]
        }
        UINavigationBar.appearance().tintColor = ColorCatalog.dark
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let splashView = SplashRouter.createSplashModule()
        window?.rootViewController = splashView
        window?.makeKeyAndVisible()
        
        return true
    }


}

