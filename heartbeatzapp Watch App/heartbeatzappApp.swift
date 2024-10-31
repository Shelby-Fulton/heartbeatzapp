//
//  heartbeatzappApp.swift
//  heartbeatzapp Watch App
//
//  Created by Shelby Fulton on 10/21/24.
//

import SwiftUI
import SocketIO
import WatchConnectivity

@main
struct heartbeatzapp_Watch_AppApp: App {
    @StateObject private var healthKitManager = HealthKitManager()
    @StateObject private var sessionDelegate = WatchSessionDelegate() // WCSession delegate instance
    
    var body: some Scene {
        WindowGroup {
            if healthKitManager.isAuthorized {
                HeartRateView()
                    .onAppear {
                        // Activate WCSession when the app launches
                        if WCSession.default.activationState != .activated {
                            WCSession.default.delegate = sessionDelegate
                            WCSession.default.activate()
                        }
                    }
            } else {
                Text("Requesting Health Data Access...")
                    .onAppear {
                        // Request authorization for HealthKit access when the app launches.
                        healthKitManager.requestAuthorization()
                    }
            }
        }
    }
}

// Create a separate WCSessionDelegate class
class WatchSessionDelegate: NSObject, ObservableObject, WCSessionDelegate {
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Handle activation state if needed
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // Handle messages received from the iOS app
        DispatchQueue.main.async {
            // Update the UI or state as needed
        }
    }
}
