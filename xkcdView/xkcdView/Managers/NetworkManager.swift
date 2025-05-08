//
//  NetworkManager.swift
//  xkcdView
//
//  Created by Jeff Pickett on 5/8/25.
//

import Foundation
import Network
import SwiftUI

class NetworkManager: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    @Published var isConnected = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}


