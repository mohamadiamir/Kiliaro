//
//  ResponseValidatorMock.swift
//  KiliaroTests
//
//  Created by Amir Mohamadi on 8/28/22.
//

import Foundation
@testable import Kiliaro

struct ResponseValidatorMock: ResponseValidatorProtocol {
    func validation<T: Codable>(response: HTTPURLResponse? = nil, data: Data?) -> (Result<T, RequestError>) {
        guard let data = data else {
            return .failure(RequestError.invalidRequest)
        }
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return .success(model)
        } catch {
            print("JSON Parse Error")
            print(error)
            return .failure(.jsonParseError)
        }
    }
}
