//
//  UnitTest.swift
//  SwiftComponentExample
//
//  Created by Jingfu Li on 2024/3/19.
//

import Foundation
import SwiftComponent

enum UnitTest {
}

extension UnitTest {
    static func test() {
        struct Man {
            let age: Int
        }

        struct Women {
            let age: Int
            init(age: Int) {
                self.age = age
            }
        }

        enum AppleColorStyle {
            case red
        }

        let p = unsafeBitCast(AppleColorStyle.self as Any.Type, to: UnsafeMutablePointer<CoreStructMetadata>.self)
        let p0 = p.pointee
        //print("kind: \(p0.coreMetadataKind())")

        let m = Man(age: 3)
        withUnsafePointer(to: m) { pointer in
            print(pointer)
        }

        let w = Women(age: 5)
        withUnsafePointer(to: w) { pointer in
            print(pointer)
        }

        testCharacter()

        enum Style: UInt {
            case color = 0x500
            case bold = 0x501
        }

        struct P1 {
            let style: Style
        }

        struct P2 {
            let s: UInt
        }

        struct P3 {
            let a: Int
            let b: Int
        }

        var p3 = P3(a: 0x201, b: 0x514)
        withUnsafeBytes(of: &p3) {
            print($0)
        }

        let p00 = P2(s: 0x201)

        var p000 = P1(style: .bold)
        withUnsafePointer(to: &p000) {
            print($0)
        }

        let s = MemoryLayout<P2>.stride
        let s1 = MemoryLayout<P1>.stride
        let s0 = MemoryLayout<Style>.stride

        print("*****: \(MemoryLayout<P1>.size) : \(MemoryLayout<P2>.stride)")

        // let r = unsafeBitCast(p00, to: P1.self)

        print(#function)
    }

    static func testCharacter() {
        // Extended grapheme cluster
        // 扩展字素簇是一个或多个 Unicode 标量的序列，它们（组合时）产生单个人类可读字符。
        // https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters
        let c0: Character = "\u{E9}"
        let c1: Character = "\u{65}\u{301}"
        print("\(c0):\(c1):\(c0 == c1)")
    }
}

extension UnitTest {
    @globalActor
    public struct SomeGlobalActor {
      public actor MyActor { }

      public static let shared = MyActor()
    }

    @SomeGlobalActor
    func myActor() {
    }
}

extension UnitTest {

    static func testCodable() {
    }
}

extension ExpressibleByNilLiteral {}

