//
//  KiliaroCollectionViewCell.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import UIKit

struct CellSizeData {
    let size: CGSize
    let space: CGFloat
}

protocol KiliaroCollectionViewCell: UICollectionViewCell {
    associatedtype model
    func configure(item: model, itemSize: CellSizeData?)
}
