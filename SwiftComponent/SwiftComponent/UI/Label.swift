//
//  Label.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/2/18.
//

import UIKit

open class Label: UIView {

    private let layoutManager = NSLayoutManager()
    private var textContainer: NSTextContainer?
    private var textStorage: TextStorage?

    /// 文本内容
    open var text: String? {
        didSet {
            setNeedsDisplayAfter()
        }
    }

    /// 字体
    open var font = UIFont.systemFont(ofSize: 20) {
        didSet {
            setNeedsDisplayAfter()
        }
    }

    /// 字的颜色
    open var color = UIColor.black {
        didSet {
            setNeedsDisplayAfter()
        }
    }

    /// 行数。0 表示无限制
    open var numberOfLines = 0 {
        didSet {
            setNeedsDisplayAfter()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setNeedsDisplayAfter() {
        DispatchQueue.main.async { [weak self] in
            self?.setNeedsDisplay()
        }
    }

    private func resetLayout(_ size: CGSize) {
        guard let text else {
            return
        }

        let textContainer = NSTextContainer(size: size)
        textContainer.maximumNumberOfLines = numberOfLines

        let textStorage = TextStorage(string: text,
                                      attributes: [
                                        .font: font,
                                        .foregroundColor: color])

        if layoutManager.textContainers.count > 0 {
            layoutManager.removeTextContainer(at: 0)
        }

        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        self.textContainer = textContainer
        self.textStorage = textStorage
    }

    open override func draw(_ rect: CGRect) {
        super.draw(rect)

        resetLayout(rect.size)

        if let textStorage {
            let range = NSRange(location: 0, length: textStorage.length)
            layoutManager.drawGlyphs(forGlyphRange: range, at: .zero)
        }
    }
}

extension Label {

    private class TextStorage: NSTextStorage {

        private var _attributedString = NSMutableAttributedString()

        override init(string str: String, attributes attrs: [NSAttributedString.Key : Any]? = nil) {
            super.init()
            _attributedString = NSMutableAttributedString(string: str, attributes: attrs)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - Must override

        override var string: String {
            _attributedString.string
        }

        override func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [NSAttributedString.Key : Any] {
            _attributedString.attributes(at: location, effectiveRange: range)
        }

        override func replaceCharacters(in range: NSRange, with str: String) {
            _attributedString.replaceCharacters(in: range, with: str)
        }

        override func setAttributes(_ attrs: [NSAttributedString.Key : Any]?, range: NSRange) {
            _attributedString.setAttributes(attrs, range: range)
        }
    }
}
