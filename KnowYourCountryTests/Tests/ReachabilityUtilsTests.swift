//
//  ReachabilityUtilsTests.swift
//  KnowYourCountryTests
//
//  Created by Nasfi on 09/02/21.
//

@testable import KnowYourCountry
import XCTest

class ReachabilityUtilsTests: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testIsReachable() {
        let utils = ReachabilityUtils()
        let url1 = URL(string: "https://www.infosys.com/")!
        XCTAssert(utils.isReachable(url: url1))
    }
}
