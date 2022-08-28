//
//  ThumbnailGridCVCell.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import UIKit

typealias ThumbnailGridData = (item: MediaModel?, itemSize: CellSizeData?)

class ThumbnailGridCVCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imgv = UIImageView()
        imgv.translatesAutoresizingMaskIntoConstraints = false
        imgv.clipsToBounds = true
        imgv.layer.cornerRadius = 5
        return imgv
    }()
    
    lazy var sizeLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .kiliaroTextColor
        lbl.backgroundColor = .kiliaroBackgroundColor.withAlphaComponent(0.3)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 5
        lbl.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return lbl
    }()
    
    var currentItem: ThumbnailGridData? {
        didSet{
            if let data = currentItem {
                load(data: data)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.removeActivityIndicator()
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                Animator.animate(type: .pop(0.2), view: self)
                UIView.animate(withDuration: 0.2) {[weak self] in
                    self?.layer.borderColor = UIColor.kiliaroMainColor.cgColor
                    self?.layoutIfNeeded()
                } completion: {[weak self] completed in
                    self?.layer.borderColor = UIColor.kiliaroTextColor.cgColor
                    self?.layoutIfNeeded()
                }
            }else{
                
            }
        }
    }
    
    private func setupViews(){
        contentView.addSubview(imageView)
        contentView.addSubview(sizeLbl)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            sizeLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            sizeLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            sizeLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = UIColor.kiliaroTextColor.cgColor
        clipsToBounds = true
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
    
    private func load(data: ThumbnailGridData){
        sizeLbl.text = "\((data.item?.size?.byteSize) ?? "")"
        guard let thumbnailUrl = data.item?.thumbnailURL,
              let cellSize = data.itemSize,
              let uniqueID = data.item?.id  else {return}
        /// the padding is for the image view margin from leading and trailing
        /// imageView size is not equal the cell size
        let query = ThumbnailResizerModel(mode: .crop, size: cellSize.size, padding: 10)
        let urlToDownload = thumbnailUrl + query.getQuery()
        imageView.downloadThumbnail(urlString: urlToDownload,
                                    uniqueID: uniqueID) {[weak self] image, url, uniqueID in
            if self?.currentItem?.item?.id == uniqueID{
                self?.imageView.image = image
            }
        }
    }

}

extension ThumbnailGridCVCell: KiliaroCollectionViewCell{    
    func configure(item: MediaModel, itemSize: CellSizeData?){
        guard let itemSize = itemSize else {return}
        currentItem = (item, itemSize)
    }
    
}

