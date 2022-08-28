//
//  KiliaroCollectionView.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import UIKit

protocol KiliaroCollectionViewDelegate: AnyObject {
    func collection(_ collectionView: UICollectionView, didDeselectItemAt index: IndexPath)
    func colelction<T>(didSelectModelAt model: T)
}

extension KiliaroCollectionViewDelegate {
    func collection(_ collectionView: UICollectionView, didDeselectItemAt index: IndexPath) { }
    func colelction<T>(didSelectModelAt model: T) { }
}

class KiliaroCollectionViewDataSource<T: KiliaroCollectionViewCell>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    var items: [T.model] = []
    var selectItem: IndexPath?
    var collectionView: UICollectionView
    var sizeData: CellSizeData?
    weak var delegate: KiliaroCollectionViewDelegate?
    private var animationType: Animator.AnimType
    private var animatedCells = [Int]()
    
    init(items: [T.model] = [],
         collectionView: UICollectionView,
         delegate: KiliaroCollectionViewDelegate,
         sizeData: CellSizeData,
         anim: Animator.AnimType = .none) {
        self.items = items
        self.collectionView = collectionView
        self.animationType = anim
        self.collectionView.register(T.self, forCellWithReuseIdentifier: String.init(describing: T.self))
        self.sizeData = sizeData
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: T.self), for: indexPath) as! T
        cell.configure(item: items[indexPath.row], itemSize: sizeData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.colelction(didSelectModelAt: items[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !animatedCells.contains(indexPath.row) {
            Animator.animate(type: animationType, view: cell)
            animatedCells.append(indexPath.row)
        }
    }
        
    public func refreshWith(_ newItems: [T.model]) {
        animatedCells.removeAll()
        self.items = newItems
        self.collectionView.reloadData()
        self.collectionView.contentOffset = .zero
    }
}

