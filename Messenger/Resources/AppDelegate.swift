//
//  AppDelegate.swift
//  Messenger
//
//  Created by developer on 6/18/22.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: ConversationVC())
        
        let myColor = UIColor(hue: 0.4, saturation: 0.25, brightness: 1, alpha: 1)
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = myColor
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.standardAppearance = barAppearance
        navigationBar.scrollEdgeAppearance = barAppearance
        
        FirebaseApp.configure()
        
        return true
    }
    
    
    
}

