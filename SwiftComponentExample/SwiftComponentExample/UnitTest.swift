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

//        let p = unsafeBitCast(Man.self as Any.Type, to: UnsafeMutablePointer<CoreStructMetadata>.self)
//        let p0 = p.pointee
        //let p1 = p0.kind.rawValue
       // print("kind: \(p0.kind)")

        let m = Man(age: 3)
        withUnsafePointer(to: m) { pointer in
            print(pointer)
        }

        let w = Women(age: 5)
        withUnsafePointer(to: w) { pointer in
            print(pointer)
        }

        testCharacter()

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

extension ExpressibleByNilLiteral {}

