//
//  ThumbnailResizerTest.swift
//  KiliaroTests
//
//  Created by Amir Mohamadi on 8/28/22.
//

import XCTest
@testable import Kiliaro

class ThumbnailResizerTest: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_init_whenGivenSize_setsSize() {
        let size = CGSize(width: 10, height: 10)
        let padding = 20.0
        let item = ThumbnailResizerModel(mode: .crop, size: size, padding: padding)
        let newSize = CGSize(width: size.width-padding, height: size.height-padding)
        XCTAssertEqual(item.width, "\(newSize.round.width)")
        XCTAssertEqual(item.height, "\(newSize.round.height)")
    }
}
