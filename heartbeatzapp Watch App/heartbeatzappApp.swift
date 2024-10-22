//
//  heartbeatzappApp.swift
//  heartbeatzapp Watch App
//
//  Created by Shelby Fulton on 10/21/24.
//

import SwiftUI

@main
struct heartbeatzapp_Watch_AppApp: App {
    @StateObject private var healthKitManager = HealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            if healthKitManager.isAuthorized {
                HeartRateView()
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
