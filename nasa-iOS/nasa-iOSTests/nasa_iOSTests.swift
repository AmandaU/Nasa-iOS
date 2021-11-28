//
//  nasa_iOSTests.swift
//  nasa-iOSTests
//
//  Created by Amanda Baret on 2021/11/27.
//

import XCTest
@testable import nasa_iOS

class nasa_iOSTests: XCTestCase {

    var photos = [PhotographInfo]()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetPhoto_Success() {
        let validation = expectation(description: "FullFill")
        NasaStore.instance.getPhotos(onDone: { photos, error in
            if let photos = photos  {
                self.photos = photos
            }
            validation.fulfill()
        })
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertTrue(!self.photos.isEmpty)
        }
    }

}
