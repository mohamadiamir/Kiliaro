//
//  dasdas.swift
//  KiliaroTests
//
//  Created by Amir Mohamadi on 8/28/22.
//

import XCTest
@testable import Kiliaro

class ShowModelTest: XCTestCase {
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_init_whenGivenTitle_setsTitle() {
        let item = ShowModel(title: "dummyTitle", downloadUrl: "")
        XCTAssertEqual(item.title, "dummyTitle")
    }
    
    func test_init_whenGivenUrl_setsUrl() {
        let item = ShowModel(title: "", downloadUrl: "dummyUrl")
        XCTAssertEqual(item.downloadUrl, "dummyUrl")
    }

}
