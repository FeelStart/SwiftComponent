//
//  CompilerUtil.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/4/24.
//

import Foundation

public struct CoreRelatedPointer<Pointee> {
    public let offset: Int

    public mutating func get() -> UnsafeMutablePointer<Pointee> {
        let offset = self.offset
        return withUnsafeMutablePointer(to: &self) {
            $0.advanced(by: offset) as! UnsafeMutablePointer<Pointee>
        }
    }
}
