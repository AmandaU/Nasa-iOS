//
//  nasa_iOSTests.swift
//  nasa-iOSTests
//
//  Created by Amanda Baret on 2021/11/27.
//

import XCTest
import Combine
@testable import nasa_iOS

class nasa_iOSTests: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []
    var error = ""

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetPhoto_Success() {
        let validation = expectation(description: "FullFill")
        NasaStore.instance.photosFetched.sink { [weak self] error in
            validation.fulfill()
        }.store(in: &cancellables)

        self.waitForExpectations(timeout: 20) { error in
            XCTAssertTrue(!NasaStore.instance.photos.isEmpty)
        }
    }

    func testImageUrlFail() {
        let validation = expectation(description: "FullFill")

        NasaStore.instance.getImageUrl(url: "&&&&&")
        NasaStore.instance.photoUrlFetched.sink { [weak self] model in
            self?.error = model.error ?? ""
            validation.fulfill()
        }.store(in: &cancellables)

        self.waitForExpectations(timeout: 20) { error in
            XCTAssertFalse(self.error.isEmpty)
        }
    }
}
