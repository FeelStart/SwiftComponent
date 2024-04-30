//
//  main.swift
//  MainSwift
//
//  Created by Jingfu Li on 2024/4/24.
//

import Foundation

enum Style: UInt {
    case color = 0x200
    case bold = 0x201
}

struct P1 {
    let style: Style
}

struct P2 {
    let s: UInt
}

let p00 = P2(s: 0x201)

let s = MemoryLayout<P2>.size
let s1 = MemoryLayout<P1>.size
let s0 = MemoryLayout<Style>.size

//let p0 = unsafeBitCast(p00, to: P1.self)
//print("\(p0.style)")

print("end")

struct M0 {
    let age: Int
}
struct M {
    let m: M0
}

print(MemoryLayout<M0>.size)
print(MemoryLayout<M>.size)
