//
//  ShowService.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/27/22.
//

import Foundation
import UIKit

typealias DownloadCompletionHandler = DownloadFileCompletionHandler

protocol ShowServiceProtocol {
    func downloadMainImage(url: String, completionHandler: @escaping DownloadCompletionHandler)
}

class ShowService: ShowServiceProtocol {
    public static let shared: ShowService = ShowService(requestManager: RequestManager.shared)
    
    private let requestManager: RequestManagerProtocol
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
    
    func downloadMainImage(url: String, completionHandler: @escaping DownloadCompletionHandler) {
        self.requestManager.downloadfile(url: url) { success, fileLocation in
            completionHandler(success, fileLocation)
        }
    }
}
