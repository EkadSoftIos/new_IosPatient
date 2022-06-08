//
//  Network.swift
//  E4 Patient
//
//  Created by Mostafa Abd ElFatah on 6/8/22.
//

import Foundation

protocol NetworkReachabilityManager {
    var isReachable:Bool { get }
    var isReachableViaWWAN:Bool { get }
    var isReachableViaWiFi:Bool { get }
    var currentReachabilityStatus:NetworkStatus { get }
}

class NetworkReachability: NetworkReachabilityManager{
    
    var handler:((NetworkStatus)-> Void)?
    // MARK: - Private properties -
    private var reachability:Reachability!
        
    // MARK: - Initializers -
    init?(){
        guard let reachability = Reachability.forInternetConnection()
        else { return nil }
        self.reachability = reachability
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reachabilityChanged),
            name: .kReachabilityChangedNotification,
            object: nil
        )
        reachability.startNotifier()
    }
    
    var isReachable:Bool {
        reachability.isReachable()
    }
    
    var isReachableViaWWAN:Bool{
        reachability.isReachableViaWWAN()
    }
    
    var isReachableViaWiFi:Bool{
        reachability.isReachableViaWWAN()
    }
    
    var currentReachabilityStatus:NetworkStatus {
        reachability.currentReachabilityStatus()
    }
    
    @objc func reachabilityChanged(notification:NSNotification) {
        handler?(currentReachabilityStatus)
    }
}

extension NSNotification.Name{
    public static let kReachabilityChangedNotification = NSNotification.Name(rawValue: "kReachabilityChangedNotification")
}
