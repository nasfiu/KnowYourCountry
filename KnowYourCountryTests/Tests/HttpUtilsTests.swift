//
//  HttpUtilsTests.swift
//  KnowYourCountryTests
//
//  Created by Nasfi on 09/02/21.
//

@testable import KnowYourCountry
import RxSwift
import XCTest

class HttpUtilsTests: XCTestCase {

    private let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testFetchData() {
        let shared = Shared.top()
        let urlSession = MockReactiveURLSession()
        shared.reactiveURLSession = urlSession
        
        let httpUtils = HttpUtils()
        httpUtils.fetchData(uriPath: "/uri_path")
            .subscribe(onSuccess: { json in
                if let jsonDict = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] {
                    XCTAssert(jsonDict["result"] as? String == "success")
                    XCTAssert(urlSession.called)
                }
            }, onError: { _ in
                XCTAssert(false)
            })
            .disposed(by: disposeBag)
    }
}
