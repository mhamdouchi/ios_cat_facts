//
//  CatFactsTests.swift
//  CatFactsTests
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

@testable import CatFacts
import XCTest

final class CatFactsTests: XCTestCase {
    func testLoadingValidImage() {
        let imageUrl = URL(string: "https://placekitten.com/g/300/250")!
        let expectedImage = UIImage(named: "cat-300-250", in: Bundle.main, compatibleWith: nil)

        let expectation = expectation(description: "Image should be loaded successfully")

        UIImageView().load(url: imageUrl) { image in
            XCTAssertNotNil(image, "Image should not be nil")
            XCTAssertEqual(image?.pngData(), expectedImage?.pngData(), "Image loaded from URL does not match expected image")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testLoadingInvalidImage() {
        let imageUrl = URL(string: "https://placekitten.com/invalid.jpg")!

        let expectation = expectation(description: "Image should be loaded successfully")

        UIImageView().load(url: imageUrl) { image in
            XCTAssertNil(image, "Image should be nil for invalid URL")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testFactLoading() async {
        let result = await APIService.shared.fetchCatFact(.english)

        switch result {
            case let .success(facts):
                XCTAssertFalse(facts.data.isEmpty, "The API response should not be empty")

                let firstFact = facts.data[0]
                XCTAssertTrue(type(of: firstFact) == String.self, "The first fact should be a string")

            case let .failure(error):
                XCTFail("The result should be a success, but got error: \(error)")
        }
    }
}
