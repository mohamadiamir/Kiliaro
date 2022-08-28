//
//  FileManagableProtocol.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import Foundation

protocol FileManagerProtocol {
    var fileManager: FileManager { get set }
    func exist(file url: String) -> FileReturnType
    func saveFile(url: String ,tempLoc: URL) -> Result<URL, Error>
    func removeFile(url: URL, completion: @escaping DataCompletion<Bool>)
    func removeAllFiles()
}

enum FileReturnType {
    case exist(URL)
    case notExist
}
