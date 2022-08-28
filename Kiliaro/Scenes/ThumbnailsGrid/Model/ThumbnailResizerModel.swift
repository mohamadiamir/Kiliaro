//
//  ThumbnailResizer.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/27/22.
//

import Foundation
import UIKit

enum ImageModes: String {
    case bb
    case crop
    case md
}

struct ThumbnailResizerModel {
    let mode: ImageModes
    let width: String
    let height: String
    
    init(mode: ImageModes, size: CGSize, padding: CGFloat = 0) {
        self.mode = mode
        let newSize = CGSize(width: size.width-padding, height: size.height-padding).round
        self.width = newSize.width
        self.height = newSize.height
    }
    
    func getQuery() -> String {
        var components = URLComponents()
        let m = URLQueryItem(name: "m", value: mode.rawValue)
        let h = URLQueryItem(name: "h", value: height)
        let w = URLQueryItem(name: "w", value: width)

        components.queryItems = [w, h, m]
        return components.string ?? ""
    }
}
