//
//  Shared.swift
//  KnowYourCity
//
//  Created by Nasfi on 07/02/21.
//

import Foundation

class Shared {
    
    static var stack: [Shared] = {
        return [Shared(populate: true)]
    }()
    
    var httpUtils: HttpUtils? = nil
    static var httpUtils: HttpUtils {
        return top().httpUtils!
    }
    
    var reachabilityUtils: ReachabilityUtils? = nil
    static var reachabilityUtils: ReachabilityUtils {
        return top().reachabilityUtils!
    }
    
    var reactiveURLSession: ReactiveURLSession? = nil
    static var reactiveURLSession: ReactiveURLSession {
        return top().reactiveURLSession!
    }
    
    init(populate: Bool) {
        if populate {
            httpUtils = HttpUtils()
            reachabilityUtils = ReachabilityUtils()
            reactiveURLSession = ReactiveURLSession()
        }
    }
    
    /// `push()` and `pop()` is used by
    /// unit testing to setup mock shared objects
    static func push() {
        stack.insert(Shared(populate: false), at: 0)
    }
    
    static func pop() {
        assert(stack.count > 1)
        stack.removeFirst()
    }
    
    static func top() -> Shared {
        return stack[0]
    }
}
