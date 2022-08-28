//
//  RequestManager.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import Foundation

typealias CodableResponse<T: Codable> = (Result<T, RequestError>) -> Void

final class RequestManager: NSObject, URLSessionDelegate {
    
    var baseApi: String = Bundle.main.getValueFromPlist(for: .ApiUrl)
    
    var session: URLSession!
    
    var responseValidator: ResponseValidatorProtocol
    
    var responseLog: URLRequestLoggableProtocol?
    
    var fileManager: FileManagerProtocol!
    
    var cacheManager: CacheManagerProtocol!
    
    typealias Headers = [String: String]
    
    static let shared = RequestManager()
    
    private override init() {
        self.responseLog = ResponseLog(isEnable: true)
        self.responseValidator = ResponseValidator()
        self.fileManager = FilesManager.standard
        self.cacheManager = CacheManager.standard
        super.init()
        self.session = URLSession(configuration: URLSessionConfiguration.ephemeral, delegate: self, delegateQueue: OperationQueue.main)
    }
    
    public init(session: URLSession, validator: ResponseValidatorProtocol) {
        self.session = session
        self.responseValidator = validator
    }
    
}

extension RequestManager: RequestManagerProtocol {
    
    var timeOutInterval: Double {
        return 40
    }
    
    func performRequestWith<T: Codable>(url: String, httpMethod: HTTPMethod, completionHandler: @escaping CodableResponse<T>) {
        let headers = headerBuilder()
        let urlRequest = requestBuilder(url: url, header: headers, httpMethod: httpMethod)
        performURLRequest(urlRequest, completionHandler: completionHandler)
    }
    
    func downloadfile(url: String, completion: @escaping (Bool, URL?) -> Void) {
        switch fileManager.exist(file: url) {
        case .exist(let url):
            print("file exist")
            completion(true, url)
        case .notExist:
            downloadFileFromAndSave(url: url, completion: completion)
        }
        
    }
    
    private func headerBuilder() -> Headers {
        let headers = [
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    private func requestBuilder(url: String, header: Headers, httpMethod: HTTPMethod) -> URLRequest {
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        var urlRequest = URLRequest(url: URL(string: baseApi + urlString)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeOutInterval)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = httpMethod.rawValue
        return urlRequest
    }
    
    private func performURLRequest<T: Codable>(_ request: URLRequest, completionHandler: @escaping CodableResponse<T>) {
        session.dataTask(with: request) { (data, response, error) in
            self.responseLog?.logResponse(response as? HTTPURLResponse, data: data, error: error, HTTPMethod: request.httpMethod)
            if error != nil {
                guard let cachedResponse = self.cacheManager.cachedResponse(for: request) else {
                    return completionHandler(.failure(RequestError.connectionError))
                }
                
                if let cachedResp = cachedResponse.data as? T {
                    let validationResult: (Result<T, RequestError>) = self.responseValidator.validation(response: cachedResp as? HTTPURLResponse, data: data)
                    return completionHandler(validationResult)
                } else {
                    return completionHandler(Result.failure(.notFound))
                }
                
            } else {
                let validationResult: (Result<T, RequestError>) = self.responseValidator.validation(response: response as? HTTPURLResponse, data: data)
                return completionHandler(validationResult)
            }
        }.resume()
    }
    
    
    private func downloadFileFromAndSave(url: String, completion: @escaping (Bool, URL?) -> Void) {
        guard let itemUrl = url.checkURLIsValid() else{
            return
        }
        // you can use NSURLSession.sharedSession to download the data asynchronously
        session.downloadTask(with: itemUrl, completionHandler: { [weak self] (location, response, error) -> Void in
            guard let self = self else { return }
            guard let tempLocation = location, error == nil else { return }
            self.responseLog?.logResponse(response as? HTTPURLResponse, data: try? Data(contentsOf: tempLocation), error: error, HTTPMethod: .none)
            switch self.fileManager.saveFile(url: url, tempLoc: tempLocation) {
            case .success(let url):
                completion(true, url)
            case .failure:
                completion(false, nil)
            }
        }).resume()
    }
}
