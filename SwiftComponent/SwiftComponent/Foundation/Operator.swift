//
//  Operator.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/4/8.
//

import Foundation

public struct AddOperator<T> {
    public let a: T
    public let b: T

    public init(a: T, b: T) {
        self.a = a
        self.b = b
    }

    public func callAsFunction() -> T where T: AdditiveArithmetic {
        a + b
    }
}

