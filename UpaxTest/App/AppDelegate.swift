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
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let loginView = LoginRouter.createLoginModule()
        window?.rootViewController = loginView
        window?.makeKeyAndVisible()
        
        return true
    }


}
