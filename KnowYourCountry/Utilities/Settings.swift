//
//  Settings.swift
//  KnowYourCountry
//
//  Created by Nasfi on 05/02/21.
//

import Foundation
import UIKit

struct Device {
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
}
