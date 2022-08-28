//
//  ThumbnailGridCVTest.swift
//  KiliaroTests
//
//  Created by Amir Mohamadi on 8/28/22.
//

import XCTest
@testable import Kiliaro

class ThumbnailGridCVCellTest: XCTestCase {

    var sut: ThumbnailGridCVCell!

    override func setUpWithError() throws {
      sut = ThumbnailGridCVCell()
    }

    override func tearDownWithError() throws {
      sut = nil
    }

    func test_hasImageView() {
        let subview = sut.imageView
        XCTAssertTrue(subview.isDescendant(of: sut.contentView))
    }
    
    func test_hasSizeLbl(){
        let subview = sut.sizeLbl
        XCTAssertTrue(subview.isDescendant(of: sut.sizeLbl))
    }

    func test_settingModel_shouldUpdateSizeLabel() throws {
        let size = 2278056
        let mediaModel = MediaModel(id: nil, userID: nil, mediaType: nil, filename: nil,
                                    size: size, createdAt: nil, thumbnailURL: nil, downloadURL: nil)
        let item = ThumbnailGridData(mediaModel, nil)
        sut.currentItem = item
        let value = try XCTUnwrap(sut.sizeLbl.text)
        XCTAssertEqual(value, size.byteSize)
    }
    
}
