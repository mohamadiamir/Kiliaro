//
//  ThumbnailGridServiceTest.swift
//  KiliaroTests
//
//  Created by Amir Mohamadi on 8/28/22.
//

import XCTest
@testable import Kiliaro

class ThumbnailGridServiceTest: XCTestCase {

    var sut: ThumbnailGridService?
    var mediaJson: Data?
    
    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: "medias", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.mediaJson = data
            } catch {
                
            }
        }
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_getObjects() {
        let urlSessionMock = URLSessionMock()
        urlSessionMock.data = mediaJson
        let mockRequestManager = RequestManagerMock(session: urlSessionMock, validator: ResponseValidatorMock())
        sut = ThumbnailGridService(requestManager: mockRequestManager)
        let expectation = XCTestExpectation(description: "Async search test")
        var object: [MediaModel]?
        
        
        sut?.get() { result in
            defer {
                expectation.fulfill()
            }
            
            switch result {
            case .success(let data):
                object = data
            case .failure:
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(object?.count == 40)
    }
}
