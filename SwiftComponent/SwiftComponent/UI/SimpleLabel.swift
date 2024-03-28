//
//  SimpleLabel.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/3/21.
//

import UIKit
import CoreText

open class SimpleLabel: UIView {

    public var font = UIFont.systemFont(ofSize: 15) {
        didSet {
            setNeedsLayout()
        }
    }

    public var color = UIColor.black {
        didSet {
            setNeedsLayout()
        }
    }

    public var text: String? {
        didSet {
            setNeedsLayout()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let text, let context = UIGraphicsGetCurrentContext() else { return }

        let attributedString = NSAttributedString(string: text,
                                                  attributes: [.font: font, .foregroundColor: color])

        let framesetter = CTFramesetterCreateWithAttributedString(attributedString as CFAttributedString)

        let path = CGPath(rect: rect, transform: nil)

        let frame = CTFramesetterCreateFrame(framesetter,
                                             CFRange(location: 0, length: attributedString.length),
                                             path,
                                             nil)

        CTFrameDraw(frame, context)
    }
}
