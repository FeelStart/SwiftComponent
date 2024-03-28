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

        print(#function)
    }
}

extension ExpressibleByNilLiteral {}

