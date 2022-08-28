//
//  AppCoordinator.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
    
    enum Destination {
        case ThumbnailsGrid
        case Show(ShowModel)
    }
    
    var navigationController: UINavigationController
    let window: UIWindow?
        
    
    init(navigationController: UINavigationController, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
        super.init()
    }
        
    func start() {
        guard let window = window else { return }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        goTo(destination: .ThumbnailsGrid)
    }
    
    func goTo(destination: Destination){
        switch destination {
        case .ThumbnailsGrid:
            let thumbsGridVC = ThumbnailsGridViewController()
            thumbsGridVC.coordinator = self
            navigationController.pushViewController(thumbsGridVC, animated: true)
        case .Show(let item):
            let showVC = ShowViewController()
            showVC.coordinator = self
            showVC.model = item
            navigationController.pushViewController(showVC, animated: true)
        }
    }
}
