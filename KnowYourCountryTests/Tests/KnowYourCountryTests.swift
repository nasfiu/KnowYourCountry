//
//  KnowYourCountryTests.swift
//  KnowYourCountryTests
//
//  Created by Nasfi on 05/02/21.
//

@testable import KnowYourCountry
import RxSwift
import XCTest

class KnowYourCountryTests: XCTestCase {

    private let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testGetCountryInfo() {
        let shared = Shared.top()
        let jsonData = loadStub(name: "CountryInfo", extnsn: "json")
        let httpUtils = MockHttpUtils(json: jsonData)
        shared.httpUtils = httpUtils
        let countryInfoViewModel = CountryInfoViewModel()
        countryInfoViewModel.getCountryInfoDetails()
            .subscribe(onSuccess: { _ in
                XCTAssert(countryInfoViewModel.title == "test_heading")
                XCTAssert(countryInfoViewModel.countryInfoList![0].title == "test_title_0")
                XCTAssert(countryInfoViewModel.countryInfoList![0].description == "test_description_0")
                XCTAssert(countryInfoViewModel.countryInfoList![0].image == "test_image_0")
            }, onError: { _ in
                XCTAssert(false)
            })
            .disposed(by: disposeBag)
    }
}
