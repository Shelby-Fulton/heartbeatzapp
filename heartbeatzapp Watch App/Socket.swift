//
//  Socket.swift
//  heartbeatzapp
//
//  Created by Meghan Harrington on 10/28/24.
//

import SocketIO
import Foundation

func create_socket() -> SocketIOClient{
    // Create a Socket.IO manager instance
    let socketManager = SocketManager(socketURL: URL(string: "http://localhost:8900")!, config: [.log(true), .compress])

    // Create a Socket.IO client
    let socket = socketManager.defaultSocket
    socket.on(clientEvent: .connect) { data, ack in
        print("Socket connected")
    }

    socket.connect()
    
    return socket
}

func send_HR_data(socket: SocketIOClient, HR_data: String) {
    let message = HR_data
    socket.emit("heart rate", HR_data)
}

