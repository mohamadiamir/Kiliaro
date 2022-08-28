//
//  ResponseLog.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import Foundation

struct ResponseLog: URLRequestLoggableProtocol {
    
    private let TAG: String = "ResponseLog: "
    var isEnable = true
    
    func logResponse(_ response: HTTPURLResponse?, data: Data?, error: Error?, HTTPMethod: String?) {
        guard isEnable else { return }
        print(TAG, "Start logApi")
        defer {
            print(TAG, "End logApi\n")
        }
        guard let _ = response else {
            print(TAG, "NULL Response ERROR")
            return
        }
        
        if let error = error {
            print(TAG, "ERROR: ", error)
        }
        
        guard let data = data else {
            print(TAG, "Empty Response ERROR ")
            return
        }
        
        print(TAG, "Response Is Valid: ")
        if let json = data.prettyPrintedJSONString {
            print(TAG, json)
        } else {
            let responseDataString: String = String(data: data, encoding: .utf8) ?? "BAD ENCODING"
            print(TAG, responseDataString)
        }
    }
}

private extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? else { return nil }
            
        return prettyPrintedString
    }
}
