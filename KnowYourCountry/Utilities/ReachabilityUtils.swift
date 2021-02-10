//
//  ReachabilityUtils.swift
//  KnowYourCity
//
//  Created by Nasfi on 07/02/21.
//

import Foundation
import SystemConfiguration

final class ReachabilityUtils {
    enum Status {
        case notReachable
        case reachable
    }
    
    static var shared: ReachabilityUtils {
        Shared.reachabilityUtils
    }
        
    func isReachable(url: URL) -> Bool {
        var reachability: Reachability?
        if let host = url.host {
                reachability = Reachability(hostName: host)
        }
        
        if let reachability = reachability {
            return reachability.status == .reachable
        }
        
        return true // can't determine, which is considered reachable so that we try making a connection anyway
    }
}

private class Reachability {
    
    private var networkReachability: SCNetworkReachability
    
    init?(hostName: String) {
        guard let data = hostName.data(using: .utf8) else {
            return nil
        }
        
        guard let networkReachability = data.withUnsafeBytes({ ptr -> SCNetworkReachability? in
            if let bytes = ptr.baseAddress?.assumingMemoryBound(to: Int8.self) {
                return SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, bytes)
            }
            else {
                return nil
            }
        }) else {
            return nil
        }
        
        self.networkReachability = networkReachability
    }
    
    var status: ReachabilityUtils.Status {
        var flags = SCNetworkReachabilityFlags()
        if SCNetworkReachabilityGetFlags(networkReachability, &flags) {
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            if isReachable && !needsConnection {
                return .reachable
            }
            else {
                return .notReachable
            }
        }
        else {
            return .reachable // if can't determine the network reachability, consider it reachable
        }
    }
}
