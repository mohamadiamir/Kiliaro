//
//  UserDefaultsConfig.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/27/22.
//

import Foundation

struct UserDefaultsConfig {
    
    enum UserDefaultsKey: String {
        case sharedKey
    }

    @UserDefault(.sharedKey, defaultValue: Bundle.main.getValueFromPlist(for: .SharedKey))
    static var sharedKey:String
}
