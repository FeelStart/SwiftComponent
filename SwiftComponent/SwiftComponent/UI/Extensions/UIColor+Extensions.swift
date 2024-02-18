//
//  UIColor+Extensions.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/2/18.
//

import UIKit

extension UIColor {

    public static var random: UIColor {
        let range = 1...256
        let red = CGFloat(range.randomElement() ?? 1) / 256
        let green = CGFloat(range.randomElement() ?? 1) / 256
        let blue = CGFloat(range.randomElement() ?? 1) / 256

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }

}
