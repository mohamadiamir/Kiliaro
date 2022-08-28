//
//  ThumbnailGridVM.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/27/22.
//

import Foundation

final class ThumbnailGridViewModel {
    
    var thumbnailGridService: ThumbnailGridServiceProtocol
    init(thumbnailGridService: ThumbnailGridServiceProtocol) {
        self.thumbnailGridService = thumbnailGridService
    }
    
    var loading: DataCompletion<Bool>?
    var mediaData: DataCompletion<[MediaModel]>?
    var errorHandler: DataCompletion<String>?
    var mediaToShow: DataCompletion<MediaModel>?
    
    func getMedias(){
        self.loading?(true)
        DispatchQueue.global(qos: .userInteractive).async {[weak self] in
            self?.thumbnailGridService.get() { result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.loading?(false)
                    switch result {
                    case .success(let medias):
                        guard let medias = medias else {
                            assertionFailure("No Data")
                            return
                        }
                        self.mediaData?(medias)
                    case .failure(let error):
                        self.errorHandler?(error.localizedDescription)
                    }
                }
            }
        }
    }

    
    func selectMedia(media: MediaModel){
        mediaToShow?(media)
    }
    
    func removeAllCache(){
        FilesManager.standard.removeAllFiles()
        CacheManager.standard.clearAllCache()
    }
}

