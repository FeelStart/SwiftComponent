//
//  Bundle+Extension.swift
//  SwiftComponentExample
//
//  Created by Jingfu Li on 2024/4/29.
//

import Foundation

extension Bundle {

    static var resource: Bundle {
        let path = Bundle.main.path(forResource: "Resource", ofType: "bundle")
        return Bundle(path: path!)!
    }

}
