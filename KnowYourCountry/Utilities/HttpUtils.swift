//
//  HttpUtils.swift
//  KnowYourCity
//
//  Created by Nasfi on 07/02/21.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

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
    
    static var shared: HttpUtils {
        Shared.httpUtils
    }
    
    func fetchData(uriPath: String, method: RequestMethod? = nil, body: Any? = nil) -> Single<Data> {
        _fetchData(uriPath: uriPath, method: method, body: body)
    }
    
    private func _fetchData(uriPath: String, method: RequestMethod?, body: Any?) -> Single<Data> {
        let urlStr = URLConstants.baseURL + uriPath
        guard let url = URL(string: urlStr) else {
            let error = createError(StringConstants.errorConstructUrl + urlStr)
            return Observable.error(error).asSingle()
        }
        _ = checkReachability(url: url)
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
                    var serverMessage = ""
                    var serverErrorCode = ""
                    if let errorPayload = try? decodeJson(jsonData: data, type: ErrorPayload.self) {
                        serverMessage = errorPayload.error?.message ?? "Error"
                        serverErrorCode = errorPayload.error?.code ?? "Error"
                    }
                    return Observable.error(createError(message, code: .unexpectedServerResponse(serverMessage, serverErrorCode)))
                }
            }
            .asSingle()
    }
    
    private func checkReachability(url: URL) -> Single<Data>? {
        guard ReachabilityUtils.shared.isReachable(url: url) else {
            let error = createError(NSLocalizedString(StringConstants.notReachable, comment: ""), code: .hostNotReachable)
            return Observable.error(error).asSingle()
        }
        return nil
    }
}
