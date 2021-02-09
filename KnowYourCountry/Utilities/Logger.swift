//
//  Logger.swift
//  KnowYourCity
//
//  Created by Nasfi on 07/02/21.
//

import Foundation

func debugLog(_ message: String) {
    #if DEBUG
    print(message)
    #endif
}
