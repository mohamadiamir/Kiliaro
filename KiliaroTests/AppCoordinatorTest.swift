//
//  AppCoordinatorTest.swift
//  KiliaroTests
//
//  Created by Amir Mohamadi on 8/28/22.
//

import XCTest
@testable import Kiliaro

class AppCoordinatorTest: XCTestCase {
    
    var sut: AppCoordinator?
    var window: UIWindow?
    
    override func tearDownWithError() throws {
        sut = nil
        window = nil
        try? super.tearDownWithError()
    }
    
    override func setUp() {
        let nav = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        sut = AppCoordinator(navigationController: nav, window: window)
    }
    
    override func tearDown() {
        sut = nil
        window = nil
    }
    
    func test_start() throws {
        guard let sut = sut else {
            throw UnitTestError()
        }
        sut.start()
        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
        let rootVC = sut.navigationController.viewControllers[0] as? ThumbnailsGridViewController
        XCTAssertNotNil(rootVC, "Check if root vsc is ThumbnailsGridViewController")
    }
    
    
    func test_gotoShow() throws{
        guard let sut = sut else {
            throw UnitTestError()
        }
        let itemToShow = ShowModel(title: "dummyTitle", downloadUrl: "dummyDownloadUrl")
        sut.goTo(destination: .Show(itemToShow))
        let detailVC = sut.navigationController.viewControllers[0] as? ShowViewController
        XCTAssertNotNil(detailVC, "Check if vc vsc is ShowViewController")
    }

}
