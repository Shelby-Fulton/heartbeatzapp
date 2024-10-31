//
//  PhoneSessionDelegate.swift
//  heatbeatziPhone
//
//  Created by Shelby Fulton on 10/31/24.
//

import Foundation
import WatchConnectivity

class PhoneSessionDelegate: NSObject, WCSessionDelegate, ObservableObject {
    @Published var displayData: String = "" // Published variable to hold incoming data

    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    // This method is called when the session becomes inactive, usually as a temporary state
    func sessionDidBecomeInactive(_ session: WCSession) {
        // Handle session inactivity if needed, e.g., pause ongoing tasks or updates.
        print("Session became inactive.")
    }
    
    // Called when the session is deactivated; typically this means the session will be transferred to another device
    func sessionDidDeactivate(_ session: WCSession) {
        // When the session is deactivated, you must call activate on the new session to complete the transfer.
        WCSession.default.activate()
        print("Session deactivated, re-activating session.")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Handle any setup after activation if needed
        if let error = error {
            print("WCSession activation failed with error: \(error.localizedDescription)")
        } else {
            print("WCSession activated with state: \(activationState.rawValue)")
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // Check if message contains displayData key
        if let data = message["displayData"] as? String {
            DispatchQueue.main.async {
                self.displayData = data // Update the displayData property
            }
            print("Received message: \(data)")
        }
    }
}
