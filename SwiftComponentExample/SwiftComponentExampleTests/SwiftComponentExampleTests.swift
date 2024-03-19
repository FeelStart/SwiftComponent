//
//  SwiftComponentExampleTests.swift
//  SwiftComponentExampleTests
//
//  Created by Jingfu Li on 2024/3/19.
//

import XCTest
import SwiftComponent

final class SwiftComponentExampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        struct Man {
            let age: Int
        }

        let m = Man(age: 20)
        print(#function)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
