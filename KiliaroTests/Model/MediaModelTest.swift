//
//  MediaModel.swift
//  KiliaroTests
//
//  Created by Amir Mohamadi on 8/28/22.
//

import XCTest
@testable import Kiliaro

class MediaModelTest: XCTestCase {

    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_init_whenGivenID_setsID() {
        let item = MediaModel(id: "dummyID", userID: nil, mediaType: nil, filename: nil, size: nil, createdAt: nil, thumbnailURL: nil, downloadURL: nil)
        XCTAssertEqual(item.id, "dummyID")
    }

    func test_init_whenUserID_UserID() {
        let item = MediaModel(id: nil, userID: "dummyUserID", mediaType: nil, filename: nil, size: nil, createdAt: nil, thumbnailURL: nil, downloadURL: nil)
        XCTAssertEqual(item.userID, "dummyUserID")
    }
    
    func test_init_whenGivenMediaType_setsMediaType() {
        let item = MediaModel(id: nil, userID: nil, mediaType: .image, filename: nil, size: nil, createdAt: nil, thumbnailURL: nil, downloadURL: nil)
        XCTAssertEqual(item.mediaType, .image)
    }
    
    func test_init_whenGivenFileName_setsFileName() {
        let item = MediaModel(id: nil, userID: nil, mediaType: nil, filename: "dummyFileName", size: nil, createdAt: nil, thumbnailURL: nil, downloadURL: nil)
        XCTAssertEqual(item.filename, "dummyFileName")
    }
    
    
    func test_init_whenGivenSize_setsSize() {
        let item = MediaModel(id: nil, userID: nil, mediaType: nil, filename: nil, size: 100, createdAt: nil, thumbnailURL: nil, downloadURL: nil)
        XCTAssertEqual(item.size, 100)
    }
    
    
    func test_init_whenGivenCreatedAt_setsCreatedAt() {
        let item = MediaModel(id: nil, userID: nil, mediaType: nil, filename: nil, size: nil, createdAt: "dummyCreatedAt", thumbnailURL: nil, downloadURL: nil)
        XCTAssertEqual(item.createdAt, "dummyCreatedAt")
    }
    
    
    func test_init_whenGivenThumbnailUrl_setsThumbnailUrl() {
        let item = MediaModel(id: nil, userID: nil, mediaType: nil, filename: nil, size: nil, createdAt: nil, thumbnailURL: "dummyThumbnailUrl", downloadURL: nil)
        XCTAssertEqual(item.thumbnailURL, "dummyThumbnailUrl")
    }
    
    
    func test_init_whenGivenDownloadUrl_setsDownloadUrl() {
        let item = MediaModel(id: nil, userID: nil, mediaType: nil, filename: nil, size: nil, createdAt: nil, thumbnailURL: nil, downloadURL: "dummyDownloadUrl")
        XCTAssertEqual(item.downloadURL, "dummyDownloadUrl")
    }
}
