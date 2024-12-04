//
//  NetworkMonitor_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import Network
import UIKit

private var _MGRE3we9fd: Bool { true }

final class NetworkMonitor_MGRE {
    
    public static var isConnection_MGRE: Bool {
        if _isConnection_MGRE {
            print("Internet connection is active.")
        } else {
            print("No internet connection.")
            showDisconnectionAlert_MGRE()
        }
        return _isConnection_MGRE
    }
    
    private static weak var alert_MGRE: UIAlertController?
    private static let queue_MGRE = DispatchQueue.global()
    private static var isAlertPresented_MGRE: Bool { alert_MGRE != nil }
    
    private static var _isConnection_MGRE: Bool = nwMonitor_MGRE.currentPath.status == .satisfied {
        didSet {
            if !_isConnection_MGRE {
                print("No internet connection.")
                showDisconnectionAlert_MGRE()
            } else {
                print("Internet connection is active.")
                if isAlertPresented_MGRE {
                    alert_MGRE?.dismiss(animated: true)
                }
            }
        }
    }
    
    private static let nwMonitor_MGRE = {
        let nwMonitor = NWPathMonitor()
        nwMonitor.start(queue: queue_MGRE)
        nwMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                _isConnection_MGRE = path.status == .satisfied
            }
        }
        return nwMonitor
    }()
    
    deinit {
        NetworkMonitor_MGRE.nwMonitor_MGRE.cancel()
    }
    
    private static func showDisconnectionAlert_MGRE() {
        guard !isAlertPresented_MGRE else { return }
        
        let alert = UIAlertController(
            title: NSLocalizedString("ConnectivityTitle", comment: ""),
            message: NSLocalizedString("ConnectivityDescription", comment: ""),
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default)
        alert.addAction(action)
        
        SceneDelegate.shared?.window?.topViewController_MGRE?.present(alert, animated: true)
        
        self.alert_MGRE = alert
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
}
