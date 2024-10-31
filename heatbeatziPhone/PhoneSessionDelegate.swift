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
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Handle any setup after activation if needed
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // Check if message contains displayData key
        if let data = message["displayData"] as? String {
            DispatchQueue.main.async {
                self.displayData = data // Update the displayData property
            }
        }
    }
}
