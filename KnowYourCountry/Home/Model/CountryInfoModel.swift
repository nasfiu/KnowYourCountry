//
//  CountryInfoModel.swift
//  KnowYourCountry
//
//  Created by Nasfi on 07/02/21.
//

import Foundation

struct CountryInfoModel: Decodable {
    var title: String?
    var countryDetailItems: [CountryDetailItem]?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case countryDetailItems = "rows"
    }
}

struct CountryDetailItem: Decodable {
    var title: String?
    var description: String?
    var image: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, description
        case image = "imageHref"
    }
}
