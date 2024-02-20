//
//  TextView.swift
//  TextViewExample
//
//  Created by Jingfu Li on 2024/2/20.
//

import UIKit
import os

/// TextKit2 实现的文本视图
open class TextView: UIView {

    var textContentStorage: NSTextContentStorage!
    var textLayoutManager: NSTextLayoutManager!
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

        textContentStorage.addTextLayoutManager(textLayoutManager!)

        let textContainer = NSTextContainer(size: CGSize(width: 1000, height: 1000))
        textLayoutManager.textContainer = textContainer
        textLayoutManager.textViewportLayoutController.delegate = self
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

extension TextView: NSTextViewportLayoutControllerDelegate {

    public func viewportBounds(for textViewportLayoutController: NSTextViewportLayoutController) -> CGRect {
        return .zero
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
