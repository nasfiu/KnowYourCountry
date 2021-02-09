//
//  JSONUtils.swift
//  KnowYourCity
//
//  Created by Nasfi on 07/02/21.
//

import Foundation

struct AnyEncodable: Encodable {
    let value: Encodable
    
    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

func decodeJson<T: Decodable>(jsonData: Data, type: T.Type = T.self) throws -> T {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: jsonData)
}

func encodeJson<T: Encodable>(_ value: T) throws -> Data {
    let encoder = JSONEncoder()
    return try encoder.encode(value)
}
