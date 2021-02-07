//
//  Constants.swift
//  KnowYourCountry
//
//  Created by Nasfi on 05/02/21.
//

import Foundation
import UIKit

struct StringConstants {
    
    static let notReachable = "Server is not reachable, please check your internet connection"
    static let errorConstructUrl = "couldn't construct the RPC URL:"
    static let unexpectedStatusCode = "unexpected status code:"
    static let errorAlertTitle = "Oops!!!"
    static let ok = "OK"
}

struct LayoutConstants {
    static let horizontalMargin:CGFloat = 16
    static let verticalMargin :CGFloat = 16
    static let innerMargin:CGFloat = 8
}

struct TextSizes {
    static let title:CGFloat = Device.IS_IPAD ? 26 : 16
    static let bodyText:CGFloat = Device.IS_IPAD ? 24 : 14
}

struct TextColor {
    static let titleColor:UIColor = .black
    static let bodyTextColor:UIColor = .darkGray
}
