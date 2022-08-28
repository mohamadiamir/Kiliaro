//
//  CacheManager.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/27/22.
//

import Foundation

class CacheManager: CacheManagerProtocol {
    static let standard = CacheManager(cacheManager: URLCache.shared)
    
    var cacheManager: URLCache
    init(cacheManager: URLCache) {
        self.cacheManager = cacheManager
    }
    
    func cachedResponse(for urlRequest: URLRequest) -> CachedURLResponse? {
        cacheDesciption()
        return cacheManager.cachedResponse(for: urlRequest)
    }
    
    internal func cacheConfig() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadRevalidatingCacheData
        config.urlCache?.memoryCapacity = 256 * 1024 * 1024
        return config
    }
    
    func clearAllCache() {
        cacheManager.removeAllCachedResponses()
        print("Cache Responsed Removed")
    }
    
    private func cacheDesciption() {
        print("Disk usage/capacity: \(cacheManager.currentDiskUsage)/\(cacheManager.diskCapacity), memory usage/capacity: \(cacheManager.currentMemoryUsage)/\(cacheManager.memoryCapacity)")
    }
}
