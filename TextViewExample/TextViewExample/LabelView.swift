//
//  TextView.swift
//  TextViewExample
//
//  Created by Jingfu Li on 2024/2/20.
//

import UIKit
import os

/// TextKit2 实现的文本视图
open class LabelView: UIView {

    private var textContentStorage: NSTextContentStorage!
    private var textLayoutManager: NSTextLayoutManager!
    private var textLayoutFragments = [NSTextLayoutFragment]()

    open var text: String? {
        didSet {
            let attributedString = NSAttributedString(string:text ?? "",
                                                      attributes: [.font: font, .foregroundColor: color])

            textContentStorage.performEditingTransaction {
                textContentStorage.textStorage?.setAttributedString(attributedString)
            }
            textLayoutManager.textViewportLayoutController.layoutViewport()
        }
    }

    open var font = UIFont.systemFont(ofSize: 20)
    open var color = UIColor.black

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false

        textLayoutManager = NSTextLayoutManager()
        textContentStorage = NSTextContentStorage()

        textContentStorage.delegate = self 
        textContentStorage.addTextLayoutManager(textLayoutManager)

        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.maximumNumberOfLines = 0

        textLayoutManager.delegate = self
        textLayoutManager.textContainer = textContainer
        textLayoutManager.textViewportLayoutController.delegate = self
    }

    open override var bounds: CGRect {
        didSet {
            textLayoutManager.textContainer?.size = bounds.size
            textLayoutManager.textViewportLayoutController.layoutViewport()
        }
    }

    open override func sizeToFit() {
        textLayoutManager.textContainer?.size = .zero
        textLayoutManager.textViewportLayoutController.layoutViewport()
        frame = textLayoutManager.usageBoundsForTextContainer
    }

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        textLayoutManager.textContainer?.size = bounds.size
        textLayoutManager.textViewportLayoutController.layoutViewport()
        return textLayoutManager.usageBoundsForTextContainer.size
    }

    open override var intrinsicContentSize: CGSize {
        textLayoutManager.textContainer?.size = .zero
        textLayoutManager.textViewportLayoutController.layoutViewport()
        return textLayoutManager.usageBoundsForTextContainer.size
    }

    open override func draw(_ rect: CGRect) {
        super.draw(rect)

        if let context = UIGraphicsGetCurrentContext() {
            var y: CGFloat = 0
            for fragment in textLayoutFragments {
                fragment.draw(at: CGPoint(x: 0, y: y), in: context)
                y += fragment.layoutFragmentFrame.height
            }
        }
    }
}

// MARK: - NSTextViewportLayoutControllerDelegate

extension LabelView: NSTextViewportLayoutControllerDelegate {

    public func viewportBounds(for textViewportLayoutController: NSTextViewportLayoutController) -> CGRect {
        return bounds
    }

    public func textViewportLayoutController(_ textViewportLayoutController: NSTextViewportLayoutController, configureRenderingSurfaceFor textLayoutFragment: NSTextLayoutFragment) {
        os_log(.info, "\(#function)")

        textLayoutFragments.append(textLayoutFragment)
        setNeedsDisplay()
    }

    public func textViewportLayoutControllerWillLayout(_ textViewportLayoutController: NSTextViewportLayoutController) {
        os_log(.info, "\(#function)")
        textLayoutFragments.removeAll()
    }

    public func textViewportLayoutControllerDidLayout(_ textViewportLayoutController: NSTextViewportLayoutController) {
        os_log(.info, "\(#function)")
    }
}

// MARK: - NSTextLayoutManagerDelegate

extension LabelView: NSTextLayoutManagerDelegate {

    public func textLayoutManager(_ textLayoutManager: NSTextLayoutManager, textLayoutFragmentFor location: NSTextLocation, in textElement: NSTextElement) -> NSTextLayoutFragment {
        os_log(.info, "\(#function)")
        return NSTextLayoutFragment(textElement: textElement, range: textElement.elementRange)
    }

    public func textLayoutManager(_ textLayoutManager: NSTextLayoutManager, shouldBreakLineBefore location: NSTextLocation, hyphenating: Bool) -> Bool {
        os_log(.info, "\(#function)")
        return false
    }

    public func textLayoutManager(_ textLayoutManager: NSTextLayoutManager, renderingAttributesForLink link: Any, at location: NSTextLocation, defaultAttributes renderingAttributes: [NSAttributedString.Key : Any] = [:]) -> [NSAttributedString.Key : Any]? {
        os_log(.info, "\(#function)")
        return nil
    }
}

// MARK: - NSTextContentStorageDelegate

extension LabelView: NSTextContentStorageDelegate {

    public func textContentStorage(_ textContentStorage: NSTextContentStorage, textParagraphWith range: NSRange) -> NSTextParagraph? {
        os_log(.info, "\(#function)")
        return nil
    }

    public func textContentManager(_ textContentManager: NSTextContentManager, textElementAt location: NSTextLocation) -> NSTextElement? {
        os_log(.info, "\(#function)")
        return nil
    }

    public func textContentManager(_ textContentManager: NSTextContentManager, shouldEnumerate textElement: NSTextElement, options: NSTextContentManager.EnumerationOptions = []) -> Bool {
        os_log(.info, "\(#function)")
        return true
    }
}

