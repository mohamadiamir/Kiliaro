//
//  FileManager.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import Foundation

final class FilesManager: FileManagerProtocol {
    static let standard = FilesManager(fileManager: FileManager.default)
    
    var fileManager: FileManager
    init(fileManager: FileManager) {
        self.fileManager = fileManager
    }
    
    private lazy var documentsDirectoryURL: URL =  {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }()
    
    private func getDestinationUrl(for url: String) -> URL {
        let itemUrl = URL(string: url)
        let destinationUrl = documentsDirectoryURL.appendingPathComponent("\(String(describing: itemUrl?.lastPathComponent)).jpg")
        print(destinationUrl)
        return destinationUrl
    }
    
    func exist(file url: String) -> FileReturnType {
        let destinationUrl = getDestinationUrl(for: url)
        if fileManager.fileExists(atPath: destinationUrl.path) {
            return .exist(destinationUrl)
        }
        
        return .notExist
    }
    
    
    func saveFile(url: String ,tempLoc: URL) -> Result<URL, Error> {
        let destinationUrl = getDestinationUrl(for: url)
        do {
            try fileManager.moveItem(at: tempLoc, to: destinationUrl)
            return .success(destinationUrl)
        } catch let error as NSError {
            print(error.localizedDescription)
            return .failure(error)
        }
    }
    
    func removeFile(url: URL, completion: @escaping DataCompletion<Bool>) {
        do {
            try fileManager.removeItem(at: url)
            completion(true)
        } catch {
            print(error)
            completion(false)
        }
    }
    
    func removeAllFiles() {
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsDirectoryURL,
                                                               includingPropertiesForKeys: nil,
                                                               options: .skipsHiddenFiles)
            for fileURL in fileURLs {
                try fileManager.removeItem(at: fileURL)
            }
        print("removed all fileManager saved data")
        } catch {
            print(error)
            print("error on deleting filemanager saved data: \(error.localizedDescription)")
        }
    }
    
}
