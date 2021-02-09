//
//  XCTestCase.swift
//  KnowYourCityTests
//
//  Created by Nasfi on 09/02/21.
//

import XCTest

extension XCTestCase {
    
    func loadStub(name: String, extnsn: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: name, withExtension: extnsn) {
            let data = (try? Data(contentsOf: url)) ?? Data()
            return data
        }
        return Data()
    }
}
