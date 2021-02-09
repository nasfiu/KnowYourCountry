//
//  MockReactiveUrlSession.swift
//  KnowYourCountryTests
//
//  Created by Nasfi on 09/02/21.
//

@testable import KnowYourCountry
import RxSwift
import XCTest

class MockReactiveURLSession: ReactiveURLSession {
    var called = false
    
    override func response(request: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)> {
        called = true
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let json = [
            "result": "success"
        ]
        let data = (try? encodeJson(json)) ?? Data()
        return Observable.just((response: response, data: data))
    }
}
