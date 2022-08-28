//
//  ShowViewController.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/27/22.
//

import UIKit
import PDFKit

class ShowViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    private let showVM: ShowViewModel = ShowViewModel(showService: ShowService.shared)
    private var datasource: KiliaroCollectionViewDataSource<ThumbnailGridCVCell>!
    
    var model: ShowModel?
    
    lazy var pdfView: PDFView = {
        let pdf = PDFView()
        pdf.translatesAutoresizingMaskIntoConstraints = false
        pdf.displayDirection = .vertical
        pdf.displayMode = .singlePage
        pdf.backgroundColor = .clear
        return pdf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBinding()
        callService()
    }
    
    deinit {
        print("released from memory", Self.description())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupViews(){
        title = model?.title.convertDateToReadable()
        view.backgroundColor = .kiliaroBackgroundColor
        view.addSubview(pdfView)
    }
    
    private func setupBinding(){
        showVM.downloadHandler = {[weak self] fileLocationUrl in
            guard let image = self?.loadImage(imageLocalUrl: fileLocationUrl) else {return}
            self?.loadPdf(image: image)
        }
        
        showVM.loading = {[weak self] isLoading in
            isLoading ? self?.view.animateActivityIndicator() : self?.view.removeActivityIndicator()
            self?.pdfView.isHidden = isLoading
        }
        
        showVM.errorHandler = {[weak self] error in
            guard let self = self else { return }
            let ac = UIAlertController(title: "Error",
                                       message: error,
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    
    private func callService(){
        guard let mediaToShow = model else {
            coordinator?.navigationController.popViewController(animated: true)
            return
        }
        showVM.downloadMainFile(from: mediaToShow.downloadUrl)
    }
    
    func loadImage(imageLocalUrl: URL)->UIImage?{
        do {
            let imageData = try Data(contentsOf: imageLocalUrl)
            let image = UIImage(data: imageData)
            return image
        } catch {
            showVM.errorHandler?("error on converting data from url")
            print("Not able to load image")
            return nil
        }
    }
    
    func loadPdf(image: UIImage?){
        guard let image = image, let pdfPage = PDFPage(image: image) else{ return }
        let pdfDoc = PDFDocument()
        pdfDoc.insert(pdfPage, at: 0)
        pdfView.document = pdfDoc
        pdfView.autoScales = true
        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
    }
}
