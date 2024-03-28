//
//  Notification.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/3/27.
//

import Foundation
import OSLog

///
/// https://medium.com/@leandromperez/strong-typed-notifications-in-swift-a5de8f7f58e0

public enum ZNotification {
}

extension ZNotification {
    class Proxy {
        static let shared = Proxy()
    }
}

public extension ZNotification {
    protocol Base {
        var identifier: String { get }
        var notificationName: Notification.Name { get }
    }
}

public extension ZNotification.Base {
    var notificationName: Notification.Name {
        Notification.Name(identifier)
    }
}

public extension ZNotification.Base where Self: RawRepresentable, Self.RawValue == String {
    var identifier: String {
        rawValue
    }
}

public extension ZNotification {
    protocol Notifiable: Base {
        associatedtype ParameterType

        func post(parameter: ParameterType)
        func addListener(_ handler: @escaping ( (_ parameter: ParameterType)-> Void) )
    }
}

public extension ZNotification.Notifiable {
    func post(parameter: ParameterType) {
        print("Post notification: name:\(notificationName) value:\(parameter)")

        NotificationCenter.default.post(name: notificationName,
                                        object: ZNotification.Proxy.shared,
                                        userInfo: ["content": parameter])
    }

    func addListener(_ handler: @escaping ( (_ parameter: ParameterType)-> Void) ) {
        print("Add notification: name:\(notificationName)")

        NotificationCenter.default.addObserver(forName: notificationName,
                                               object: ZNotification.Proxy.shared,
                                               queue: .current) {
            if let parameter = $0.userInfo?["content"] as? ParameterType {
                handler(parameter)
            }

            print("Recv notification: name:\(notificationName) value: \(String(describing: $0.userInfo?["content"]))")
        }
    }
}
