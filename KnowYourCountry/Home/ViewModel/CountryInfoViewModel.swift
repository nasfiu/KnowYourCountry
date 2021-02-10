//
//  CountryInfoViewModel.swift
//  KnowYourCountry
//
//  Created by Nasfi on 07/02/21.
//

import Foundation
import RxSwift

final class CountryInfoViewModel {
    
    var title: String?
    var countryInfoList: [CountryDetailItem]?
    
    func getCountryInfoDetails() -> Single<()> {
        let urlString = URLConstants.EndPoints.getCountryInfo
        return HttpUtils.shared.fetchData(uriPath: urlString, method: .get, body: nil).map {[unowned self] json in
            if let data = try? decodeJson(jsonData: json, type: CountryInfoModel.self) {
                self.countryInfoList = data.countryDetailItems!.filter {
                    $0.description != nil && $0.title != nil
                }
                self.title = data.title ?? ""
            }
        }
    }
}
