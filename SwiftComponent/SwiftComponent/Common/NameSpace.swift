//
//  NameSpace.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/6/11.
//

import Foundation

public struct NameSpace<T> {
    let wrappedValue: T

    public init(_ wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

public protocol NameSpaceProtocol {
    associatedtype T

    var z: NameSpace<T> { get }

    static var z: T.Type { get }
}

public extension NameSpaceProtocol {

    var z: NameSpace<Self> { NameSpace(self) }

    static var z: NameSpace<Self>.Type { NameSpace<Self>.self }
}

extension NameSpace where T: NSObject {
}
