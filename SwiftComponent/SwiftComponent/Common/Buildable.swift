//
//  Buildable.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/6/3.
//

import UIKit

public protocol ViewBuilder {

    static func build<T: UIView>(block: (T)-> Void) -> T
}

extension ViewBuilder {

    public static func build<T: UIView>(block: (T)-> Void) -> T {
        var view = T()
        block(view)
        return view
    }
}

extension UIView: ViewBuilder {}
