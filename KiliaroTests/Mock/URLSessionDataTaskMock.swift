//
//  URLSessionDataTaskMock.swift
//  KiliaroTests
//
//  Created by Amir Mohamadi on 8/28/22.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
