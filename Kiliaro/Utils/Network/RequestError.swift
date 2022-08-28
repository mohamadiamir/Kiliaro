//
//  RequestError.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import Foundation

enum RequestError: Error, LocalizedError {
    case unknownError
    case connectionError
    case authorizationError
    case invalidRequest
    case notFound
    case serverUnavailable
    case jsonParseError
}

extension RequestError {
    public var errorDescription: String? {
        switch self {
        case .connectionError:
            return "Internet Connection Error"
        case .notFound:
            return "Request not found"
        case .jsonParseError:
            return "JSON parsing probelm, make sure response has a valid JSON"
        default:
            return "Network Error with` \(self)` thrown"
        }
    }
}
