//
//  NetworkTracking.swift
//  NetworkTracking
//
//  Created by 김지현 on 8/21/24.
//

import Foundation
import Network

import NetworkTrackingInterface

import Dependencies

extension NetworkTracking: DependencyKey {
  public static let liveValue: NetworkTracking = .live()
  
  public static func live() -> NetworkTracking {
    return NetworkTracking(
      updateNetworkConnected: {
        let networkMonitor = NWPathMonitor()
        let globalQueue = DispatchQueue.global()
        
        networkMonitor.start(queue: globalQueue)
        return AsyncStream<Bool> { continuation in
          networkMonitor.pathUpdateHandler = { path in
            let isConnected = path.status == .satisfied ? true : false
            continuation.yield(isConnected)
          }
          continuation.onTermination = { _ in
            networkMonitor.cancel()
          }
        }
      }
    )
  }
}
