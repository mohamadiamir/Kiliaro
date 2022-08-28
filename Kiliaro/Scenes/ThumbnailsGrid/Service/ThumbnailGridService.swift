//
//  ThumbnailGridService.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/27/22.
//

import Foundation

typealias ThumbnailGridCompletionHandler = (Result<[MediaModel]?, RequestError>) -> Void

protocol ThumbnailGridServiceProtocol {
    func get(completionHandler: @escaping ThumbnailGridCompletionHandler)
}

private enum ThumbnailEndpoint {
    case get
    
    var path: String {
        switch self {
        case .get:
            return "shared/\(UserDefaultsConfig.sharedKey)/media"
        }
    }
}

class ThumbnailGridService: ThumbnailGridServiceProtocol {
    public static let shared: ThumbnailGridService = ThumbnailGridService(requestManager: RequestManager.shared)
    
    private let requestManager: RequestManagerProtocol
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
    
    
    func get(completionHandler: @escaping ThumbnailGridCompletionHandler) {
        self.requestManager.performRequestWith(url: ThumbnailEndpoint.get.path, httpMethod: .get) {
            (result: Result<[MediaModel]?, RequestError>) in
            completionHandler(result)
        }
    }
}
