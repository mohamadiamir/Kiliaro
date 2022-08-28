//
//  AppDelegate.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setup()
        
        return true
    }

    private func setup(){
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = KiliaroNavigationController()
        appCoordinator = AppCoordinator(navigationController: navigationController, window: window)
        appCoordinator.start()
    }
    
    
    
    
}

