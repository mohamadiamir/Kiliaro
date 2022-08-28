//
//  ShowViewModel.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/27/22.
//

import Foundation

final class ShowViewModel {
    
    var showService: ShowServiceProtocol
    init(showService: ShowServiceProtocol) {
        self.showService = showService
    }
    
    var loading: DataCompletion<Bool>?
    var downloadHandler: DataCompletion<URL>?
    var errorHandler: DataCompletion<String>?
    
    func downloadMainFile(from url: String) {
        loading?(true)
        DispatchQueue.global(qos: .userInteractive).async {[weak self] in
            self?.showService.downloadMainImage(url: url) { [weak self] (success, fileLocation) in
                DispatchQueue.main.async {
                    guard let self = self else  { return }
                    self.loading?(false)
                    if let url = fileLocation, success {
                        self.downloadHandler?(url)
                    } else {
                        self.errorHandler?("error on Download")
                    }
                }
            }
        }
    }
}

