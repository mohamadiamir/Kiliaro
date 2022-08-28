//
//  CGSize+Extension.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/27/22.
//

import CoreGraphics.CGBase

extension CGSize {
    var round: (width: String, height: String){
        let width = String(format: "%.0f", self.width)
        let height = String(format: "%.0f", self.height)
        return (width, height)
    }
}
