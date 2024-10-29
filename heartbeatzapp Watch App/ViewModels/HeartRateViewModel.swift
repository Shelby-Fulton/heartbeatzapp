//
//  HeartRateViewModel.swift
//  heartbeatzapp Watch App
//
//  Created by Shelby Fulton on 10/21/24.
//

import Foundation
import HealthKit
import SocketIO

class HeartRateViewModel: ObservableObject {
    
    // Declare a published property to hold heart rate data, initializing it with a heart rate of 0.0.
    @Published var heartRateModel: HeartRateModel = HeartRateModel(heartRate: 0.0)
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    init() {
        self.manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(false), .compress])
        self.socket = self.manager.defaultSocket
        
        socket.on(clientEvent: .connect) { data, ack in
            print("Socket connected")
        }
        
        socket.on(clientEvent: .disconnect) {data, ack in
            print("Socket disconnected")
        }

        socket.connect()
        
    }
    
    // Define a function to start querying heart rate data.
    func startHeartRateQuery() {
        // Use the shared instance of HeartRateManager to start the query, using the startHeartRateQuery function inside it.
        HeartRateManager.shared.startHeartRateQuery { [weak self] samples in
            // Call the process method to handle the returned samples.
            self?.process(samples)
        }
    }
    
    // Define a private function to process the retrieved samples.
    private func process(_ samples: [HKSample]?) {
        // Ensure the samples are of type HKQuantitySample.
        guard let samples = samples as? [HKQuantitySample] else {
            return
        }

        // This code runs on the main thread to update the UI.
        DispatchQueue.main.async {
            // Update the heart rate model with the latest heart rate value, defaulting to 0.0 if no samples are available.
            self.heartRateModel.heartRate = samples.last?.quantity.doubleValue(for: .count().unitDivided(by: .minute())) ?? 0.0
            self.socket.emit("heart rate", String(self.heartRateModel.heartRate)) // send out updated heart rate data
        }
    }
    

    func send_HR_data(socket: SocketIOClient, HR_data: String) {
        let message = HR_data
        socket.emit("heart rate", HR_data)
    }
    
    
    
}
