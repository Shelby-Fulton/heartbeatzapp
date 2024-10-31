//
//  ContentView.swift
//  heatbeatziPhone
//
//  Created by Shelby Fulton on 10/31/24.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @StateObject private var sessionDelegate = PhoneSessionDelegate() // ObservedObject for updates
    
    var body: some View {
        VStack {
            Text("Data from Watch:")
            Text(sessionDelegate.displayData) // Display data received from Watch
                .font(.largeTitle)
                .padding()
        }
        .onAppear {
            // Ensure WCSession is activated if not already
            if WCSession.isSupported() {
                WCSession.default.delegate = sessionDelegate
                WCSession.default.activate()
            }
        }
    }
}
