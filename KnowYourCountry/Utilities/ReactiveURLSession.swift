//
//  ReactiveURLSession.swift
//  KnowYourCity
//
//  Created by Nasfi on 07/02/21.
//

import Foundation
import RxSwift

class ReactiveURLSession {
    
    static var shared:ReactiveURLSession{
        return Shared.reactiveURLSession
    }
    
    private let urlSession: URLSession
    
    init() {
        urlSession = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: nil
        )
    }
    
    func response(request: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)> {
        return urlSession.rx.response(request: request)
    }
}
