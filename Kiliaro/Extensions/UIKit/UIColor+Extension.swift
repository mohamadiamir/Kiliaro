//
//  UIColor+Extension.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import Foundation

import UIKit

extension UIColor {
    
    enum AppColor: String{
        case Background = "Background"
        case MainColor = "MainColor"
        case TextColor = "TextColor"
        
        var color: UIColor {
            guard let color = UIColor(named: rawValue) else {
                return .red
            }
            return color
        }
    }
    
    static var kiliaroMainColor: UIColor = {
        AppColor.MainColor.color
    }()
    
    static var kiliaroBackgroundColor: UIColor = {
        AppColor.Background.color
    }()
    
    static var kiliaroTextColor: UIColor = {
        AppColor.TextColor.color
    }()
}
