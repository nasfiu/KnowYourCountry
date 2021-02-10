//
//  Shared.swift
//  KnowYourCity
//
//  Created by Nasfi on 07/02/21.
//

import Foundation

final class Shared {
    
    static var stack: [Shared] = {
        [Shared(populate: true)]
    }()
    
    var httpUtils: HttpUtils?
    static var httpUtils: HttpUtils {
        top().httpUtils!
    }
    
    var reachabilityUtils: ReachabilityUtils?
    static var reachabilityUtils: ReachabilityUtils {
        top().reachabilityUtils!
    }
    
    var reactiveURLSession: ReactiveURLSession?
    static var reactiveURLSession: ReactiveURLSession {
        top().reactiveURLSession!
    }
    
    init(populate: Bool) {
        if populate {
            httpUtils = HttpUtils()
            reachabilityUtils = ReachabilityUtils()
            reactiveURLSession = ReactiveURLSession()
        }
    }
    
    // `push()` and `pop()` is used by
    // unit testing to setup mock shared objects
    static func push() {
        stack.insert(Shared(populate: false), at: 0)
    }
    
    static func pop() {
        assert(stack.count > 1)
        stack.removeFirst()
    }
    
    static func top() -> Shared {
        stack[0]
    }
}
