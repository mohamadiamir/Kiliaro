//
//  URLRequestLogableProtocol.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import Foundation

protocol URLRequestLoggableProtocol {
    func logResponse(_ response: HTTPURLResponse?, data: Data?, error: Error?, HTTPMethod: String?)
}
