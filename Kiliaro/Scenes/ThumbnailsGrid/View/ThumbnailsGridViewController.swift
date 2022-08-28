//
//  ThumbnailsGridViewController.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import UIKit

class ThumbnailsGridViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    private let thumbnailGridVM: ThumbnailGridViewModel = ThumbnailGridViewModel(thumbnailGridService: ThumbnailGridService.shared)
    private var datasource: KiliaroCollectionViewDataSource<ThumbnailGridCVCell>!

    let sizeData: CellSizeData = {
        let space = UIScreen.main.bounds.width / 50
        let sizeW = (UIScreen.main.bounds.width - (space*4)) / 3
        let size = CGSize(width: sizeW, height: sizeW)
        return CellSizeData(size: size, space: space)
    }()
    
    lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.itemSize = sizeData.size
        flow.sectionInset = UIEdgeInsets(top: sizeData.space, left: sizeData.space, bottom: sizeData.space, right: sizeData.space)
        flow.minimumLineSpacing = sizeData.space
        flow.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var refreshBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .refresh,
                                     target: self,
                                     action: #selector(refreshPressed))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBinding()
        callService()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupViews(){
        title = "Kiliaro"
        view.backgroundColor = .kiliaroBackgroundColor
        view.addSubview(collectionView)
        
        datasource = KiliaroCollectionViewDataSource(collectionView: collectionView,
                                                     delegate: self,
                                                     sizeData: sizeData,
                                                     anim: .expand(0.4))
        collectionView.dataSource = datasource
        collectionView.delegate = datasource
        
        self.navigationItem.setRightBarButton(refreshBtn, animated: true)
    }
    
    private func setupBinding(){
        thumbnailGridVM.mediaData = {[weak self] medias in
            self?.datasource.refreshWith(medias)
        }
        
        thumbnailGridVM.loading = {[weak self] isLoading in
            isLoading ? self?.view.animateActivityIndicator() : self?.view.removeActivityIndicator()
            self?.navigationItem.rightBarButtonItem?.isEnabled = !isLoading
            self?.collectionView.isHidden = isLoading
        }
        
        thumbnailGridVM.errorHandler = {[weak self] error in
            guard let self = self else { return }
            let ac = UIAlertController(title: "Error",
                                        message: error,
                                        preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
        
        thumbnailGridVM.mediaToShow = {[weak self] media in
            guard let url = media.downloadURL, let createdAt = media.createdAt else {return}
            let model = ShowModel(title: createdAt.convertDateToReadable() , downloadUrl: url)
            self?.coordinator?.goTo(destination: .Show(model))
        }
    }
    
    private func callService(){
        thumbnailGridVM.getMedias()
    }
    
    @objc private func refreshPressed() {
        thumbnailGridVM.removeAllCache()
        callService()
    }
}


extension ThumbnailsGridViewController: KiliaroCollectionViewDelegate {
    func colelction<T>(didSelectModelAt model: T) {
        if let media = model as? MediaModel{
            thumbnailGridVM.selectMedia(media: media)
        }
    }
}
