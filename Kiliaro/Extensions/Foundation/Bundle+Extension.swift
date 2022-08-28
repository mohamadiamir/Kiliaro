//
//  Bundle+Extension.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/27/22.
//

import Foundation

enum InfoKeys: String {
    case ApiUrl = "BaseAPIURL"
    case SharedKey = "APISharedKey"
}

extension Bundle {
    func getValueFromPlist(for key: InfoKeys) -> String {
        guard let value = infoDictionary?[key.rawValue] else {
            fatalError()
        }
        return (value as! String).replacingOccurrences(of: "\\", with: "")
    }
}
