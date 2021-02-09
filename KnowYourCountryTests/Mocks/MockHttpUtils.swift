//
//  MockHttpUtils.swift
//  KnowYourCountryTests
//
//  Created by Nasfi on 09/02/21.
//

@testable import KnowYourCountry
import RxSwift
import XCTest

class MockHttpUtils: HttpUtils {

    struct Record {
        var uriPath: String
        var requestMethod: RequestMethod?
    }

    var records: [Record] = []
    var jsonResponse: Data?
        
    var uriPath: String {
        records[0].uriPath
    }
    var requestMethod: RequestMethod? {
        records[0].requestMethod
    }
    
    convenience init(json: Data) {
        self.init(jsonResponses: json)
    }
    
    init(jsonResponses: Data) {
        self.jsonResponse = jsonResponses
        super.init()
    }
    
    override func fetchData(uriPath: String, method: HttpUtils.RequestMethod? = nil, body: Any? = nil) -> Single<Data> {
        let record = Record(
                uriPath: uriPath,
                requestMethod: method
        )
        records.append(record)

        let json = jsonResponse
        return Single.just(json!)
    }
}
