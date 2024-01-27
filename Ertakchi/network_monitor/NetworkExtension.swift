//
//  NetworkExtension.swift
//  TourismApp
//
//  Created by Bahodirkhon Khamidov on 27/01/24.
//

import UIKit

extension UIViewController {
    func startMonitoring() {
        NetworkMonitor.shared.startMonitoring()
    }
    
    func stopMonitoring() {
        NetworkMonitor.shared.stopMonitoring()
    }
}
