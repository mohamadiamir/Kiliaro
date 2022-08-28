//
//  UIImageView+Extension.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/27/22.
//

import UIKit

extension UIImageView {
    func downloadThumbnail(urlString: String?, uniqueID: String,
                           completed: @escaping ((UIImage, String, String) -> Void)) {
        guard let url = urlString?.checkURLIsValid() else{
            self.image = UIImage(named: "placeholder")
            return
        }
        
        self.animateActivityIndicator()
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.removeActivityIndicator()
            completed(image, urlString!, uniqueID)
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, _) in
                if let data = data, let response = response, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.removeActivityIndicator()
                        completed(image, urlString!, uniqueID)
                    }
                }
            }).resume()
        }
    }
}
