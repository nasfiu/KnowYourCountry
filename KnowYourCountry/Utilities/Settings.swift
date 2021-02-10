//
//  Settings.swift
//  KnowYourCountry
//
//  Created by Nasfi on 05/02/21.
//

import Foundation
import UIKit

enum Device {
    static let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    static let isIphone = UIDevice.current.userInterfaceIdiom == .phone
}
