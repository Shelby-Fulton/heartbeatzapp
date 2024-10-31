//
//  heatbeatziPhoneApp.swift
//  heatbeatziPhone
//
//  Created by Shelby Fulton on 10/31/24.
//

import SwiftUI
import WatchConnectivity

@main
struct LiveHeartRate_Watch_AppApp: App {
    
    @StateObject private var sessionDelegate = PhoneSessionDelegate() // WCSession delegate instance

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .onAppear {
                        // Activate WCSession when the app launches
                        if WCSession.isSupported() {
                            WCSession.default.delegate = sessionDelegate
                            WCSession.default.activate()
                        }
                    }
            }
    }
}
