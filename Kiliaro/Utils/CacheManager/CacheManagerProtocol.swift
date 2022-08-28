//
//  CacheManagerProtoco.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/27/22.
//

import Foundation

protocol CacheManagerProtocol {
    var cacheManager: URLCache { get set }
    func cachedResponse(for urlRequest: URLRequest) -> CachedURLResponse?
    func clearAllCache()
    func cacheConfig() -> URLSessionConfiguration
}
