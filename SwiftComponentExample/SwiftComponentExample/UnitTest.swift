//
//  UnitTest.swift
//  SwiftComponentExample
//
//  Created by Jingfu Li on 2024/3/19.
//

import Foundation

enum UnitTest {
}

extension UnitTest {
    static func test() {
        struct Man {
            let age: Int
        }

        class Women {
            let age: Int
            init(age: Int) {
                self.age = age
            }
        }

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

extension ExpressibleByNilLiteral {}

