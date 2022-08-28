//
//  ResponseValidator.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import Foundation

struct ResponseValidator: ResponseValidatorProtocol {
    
    func validation<T: Codable>(response: HTTPURLResponse?, data: Data?) -> (Result<T, RequestError>) {
        guard let response = response, let data = data else {
            return .failure(RequestError.invalidRequest)
        }
        switch response.statusCode {
        case 200...201:
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                return .success(model)
            } catch {
                print("JSON Parse Error")
                print(error)
                return .failure(.jsonParseError)
            }
        case 400...499:
            return .failure(.authorizationError)
        case 500...599:
            return .failure(.serverUnavailable)
        default:
            return .failure(RequestError.unknownError)
        }
    }
}



