//
//  HttpUtils.swift
//  KnowYourCity
//
//  Created by Nasfi on 07/02/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct ErrorPayload: Decodable {
    let error: ErrorDetailPayload?
}

struct ErrorDetailPayload: Decodable {
    let message: String?
    let code: String?
}

class HttpUtils {
    
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    static var shared:HttpUtils{
        return Shared.httpUtils
    }
    
    func fetchData(uriPath: String, method: RequestMethod? = nil, body: Any? = nil) -> Single<Data>
    {
        return _fetchData(uriPath: uriPath, method: method, body: body)
    }
    
    private func _fetchData(uriPath: String, method: RequestMethod?, body: Any?) -> Single<Data> {
        
        let baseUrl: String = URLConstants.baseURL
        
        let urlStr = baseUrl + uriPath
        guard let url = URL(string: urlStr) else {
            let error = createError(StringConstants.errorConstructUrl + urlStr)
            return Observable.error(error).asSingle()
        }
        
        guard ReachabilityUtils.shared.isReachable(url: url) else {
            let error = createError(code: .hostNotReachable, NSLocalizedString(StringConstants.notReachable, comment: ""))
            return Observable.error(error).asSingle()
        }
        
        debugLog("making REST call to: \(urlStr)")
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        
        if let method = method {
            request.httpMethod = method.rawValue
        }
        
        return ReactiveURLSession.shared.response(request: request)
            .flatMap { (response: HTTPURLResponse, data: Data) throws -> Observable<Data> in
                if 200 ..< 300 ~= response.statusCode {
                    if let string = String(data: data, encoding: String.Encoding.isoLatin1) {
                        let json = string.data(using: .utf8, allowLossyConversion: true)
                        return Observable.just(json ?? data)
                    }
                    return Observable.just(data)
                }
                else {
                    var message = "\(StringConstants.unexpectedStatusCode) + \(response.statusCode)"
                    if let bodyStr = String(data: data, encoding: .utf8) {
                        message += ", response body: \(bodyStr)"
                    }
                    
                    let serverMessage: String?
                    let serverErrorCode: String?
                    if let errorPayload = try? decodeJson(jsonData: data, type: ErrorPayload.self) {
                        serverMessage = errorPayload.error?.message
                        serverErrorCode = errorPayload.error?.code
                    } else {
                        serverMessage = nil
                        serverErrorCode = nil
                    }
                    if response.statusCode == 403 {
                        //Forbidden
                    }
                    
                    return Observable.error(createError(code: .unexpectedServerResponse(serverMessage, serverErrorCode), message))
                }
        }
        .asSingle()
    }
}
