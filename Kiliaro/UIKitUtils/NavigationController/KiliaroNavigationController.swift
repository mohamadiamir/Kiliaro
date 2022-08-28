//
//  KiliaroNavigationController.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import UIKit

class KiliaroNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews(){
        navigationBar.barTintColor = .kiliaroMainColor
        navigationBar.tintColor = .kiliaroTextColor
        
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .kiliaroMainColor
            navigationBar.standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
