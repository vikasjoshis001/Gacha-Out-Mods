//
//  InternetManager_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import SystemConfiguration

final class InternetManager_MGRE {
    
    static let shared = InternetManager_MGRE()
    
    private init() {}
    
    func checkInternetConnectivity_MGRE() -> Bool {
        var _MGRE20: String { "_MGRE" }
        var _MGRE21: Bool { true }
        
        var zeroAddress_MGRE = sockaddr_in()
        zeroAddress_MGRE.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress_MGRE))
        zeroAddress_MGRE.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability_MGRE = withUnsafePointer(to: &zeroAddress_MGRE, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability_MGRE, &flags) {
            return false
        }
        
        let isReachable_MGRE = flags.contains(.reachable)
        let needsConnection_MGRE = flags.contains(.connectionRequired)
        
        if isReachable_MGRE && !needsConnection_MGRE {
            // Connected to the internet
            // Do your network-related tasks here
            return true
        } else {
            // Not connected to the internet
            return false
        }
    }
}
