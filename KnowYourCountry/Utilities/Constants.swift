//
//  Constants.swift
//  KnowYourCountry
//
//  Created by Nasfi on 05/02/21.
//

import Foundation
import UIKit

enum StringConstants {
    
    static let notReachable = "Server is not reachable, please check your internet connection"
    static let errorConstructUrl = "couldn't construct the RPC URL:"
    static let unexpectedStatusCode = "unexpected status code:"
    static let errorAlertTitle = "Oops!!!"
    static let ok = "OK"
}

enum LayoutConstants {
    static let horizontalMargin: CGFloat = 16
    static let verticalMargin: CGFloat = 16
    static let innerMargin: CGFloat = 8
}

enum TextSizes {
    static let title: CGFloat = Device.isIpad ? 26 : 16
    static let bodyText: CGFloat = Device.isIpad ? 24 : 14
}

enum TextColor {
    static let titleColor: UIColor = .black
    static let bodyTextColor: UIColor = .darkGray
}
