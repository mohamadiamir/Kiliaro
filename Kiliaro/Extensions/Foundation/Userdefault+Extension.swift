//
//  Userdefaults+Extension.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/27/22.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: UserDefaultsConfig.UserDefaultsKey
    let defaultValue: T

    init(_ key: UserDefaultsConfig.UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
