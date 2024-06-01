//
//  UIView+Extension.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/4/16.
//

import UIKit

// MARK: - Keyboard

extension UIView {

    @available(iOS, introduced: 13, deprecated: 15)
    public var keyboardLayoutGuide: UILayoutGuide {
        if let layoutGuide = layoutGuides.first(where: { $0.identifier == Self.KeyboardLayoutGuideIdentifer }) {
            return layoutGuide
        }
        let layoutGuide = KeyboardLayoutGuide()
        addLayoutGuide(layoutGuide)
        return layoutGuide
    }

    static var KeyboardLayoutGuideIdentifer = "iOS13-iOS15-KeyboardLayoutGuideIdentifer"

    class KeyboardLayoutGuide: UILayoutGuide {
        override init() {
            super.init()

            identifier = KeyboardLayoutGuideIdentifer

            let center = NotificationCenter.default

            center.addObserver(self,
                               selector: #selector(keyboardWillChangeFrameNotification(_:)),
                               name: UIResponder.keyboardWillChangeFrameNotification,
                               object: nil)

            center.addObserver(self,
                               selector: #selector(keyboardWillHideNotification(_:)),
                               name: UIResponder.keyboardWillHideNotification,
                               object: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func updateConstraints(_ height: CGFloat) {
            guard let view = owningView else { return }
            NSLayoutConstraint.activate([
                heightAnchor.constraint(equalToConstant: height),
                leftAnchor.constraint(equalTo: view.leftAnchor),
                rightAnchor.constraint(equalTo: view.rightAnchor),
                bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }

        @objc
        func keyboardWillChangeFrameNotification(_ notification: Notification) {
        }

        @objc
        func keyboardWillHideNotification(_ notification: Notification) {
        }
    }
}

/*
 import UIKit

 extension UIView {

     @objc
     public var zKeyboardLayoutGuide: UILayoutGuide {
         if let layoutGuide = layoutGuides.first(where: { $0.identifier == KeyboardLayoutGuide.identifer }) {
             return layoutGuide
         }
         let layoutGuide = KeyboardLayoutGuide()
         addLayoutGuide(layoutGuide)
         layoutGuide.setupConstraints()
         return layoutGuide
     }

 }

 class KeyboardLayoutGuide: UILayoutGuide {

     static var identifer = "zKeyboardLayoutGuideIdentifer"

     var heightConstraint: NSLayoutConstraint?

     override init() {
         super.init()

         identifier = Self.identifer

         let center = NotificationCenter.default
         center.addObserver(self, selector: #selector(keyboardChangeNotification(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
         center.addObserver(self, selector: #selector(keyboardChangeNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
     }

     @available(*, unavailable)
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     func setupConstraints() {
         guard let view = owningView else { return }

         heightConstraint = heightAnchor.constraint(equalToConstant: 0)
         NSLayoutConstraint.activate([
             heightConstraint!,
             leftAnchor.constraint(equalTo: view.leftAnchor),
             rightAnchor.constraint(equalTo: view.rightAnchor),
             bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
     }

     @objc
     func keyboardChangeNotification(_ notification: NSNotification) {
         guard let userInfo = notification.userInfo,
               let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
             return
         }

         heightConstraint?.constant = if UIResponder.keyboardWillHideNotification == notification.name { self.owningView?.safeAreaInsets.bottom ?? 0 } else { keyboardFrame.cgRectValue.height }

         if let _ = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
             UIView.performWithoutAnimation {
                 self.owningView?.layoutIfNeeded()
             }
         }
     }

 }
 */

/*
 extension UIView {

     @available(iOS, introduced: 13, deprecated: 15)
     @objc
     public var keyboardLayoutGuide: UILayoutGuide {
         if let layoutGuide = layoutGuides.first(where: { $0.identifier == KeyboardLayoutGuide.identifer }) {
             return layoutGuide
         }
         let layoutGuide = KeyboardLayoutGuide()
         addLayoutGuide(layoutGuide)
         layoutGuide.setupConstraints()
         return layoutGuide
     }

 }

 class KeyboardLayoutGuide: UILayoutGuide {

     static var identifer = "iOS13-iOS15-KeyboardLayoutGuideIdentifer"

     var heightConstraint: NSLayoutConstraint?

     override init() {
         super.init()

         identifier = Self.identifer

         let center = NotificationCenter.default
         center.addObserver(self, selector: #selector(keyboardChangeNotification(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
         center.addObserver(self, selector: #selector(keyboardChangeNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
     }

     @available(*, unavailable)
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     func setupConstraints() {
         guard let view = owningView else { return }

         heightConstraint = heightAnchor.constraint(equalToConstant: 0)
         NSLayoutConstraint.activate([
             heightConstraint!,
             leftAnchor.constraint(equalTo: view.leftAnchor),
             rightAnchor.constraint(equalTo: view.rightAnchor),
             bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
         ])
     }

     @objc
     func keyboardChangeNotification(_ notification: NSNotification) {
         guard let userInfo = notification.userInfo,
               let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
             return
         }

         let height: CGFloat = if notification.name == UIResponder.keyboardWillHideNotification { 0.0 } else { keyboardFrame.cgRectValue.height }
         heightConstraint?.constant = height

         if let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat {
             UIView.performWithoutAnimation {
                 self.owningView?.layoutIfNeeded()
             }
         }
     }

 }

 */

/*

 import UIKit

 internal class Keyboard {
     static let shared = Keyboard()
     var currentHeight: CGFloat = 0
 }

 extension UIView {
     private enum Identifiers {
         static var usingSafeArea = "KeyboardLayoutGuideUsingSafeArea"
         static var notUsingSafeArea = "KeyboardLayoutGuide"
     }

     /// A layout guide representing the inset for the keyboard.
     /// Use this layout guide’s top anchor to create constraints pinning to the top of the keyboard or the bottom of safe area.
     public var keyboardLayoutGuide: UILayoutGuide {
         getOrCreateKeyboardLayoutGuide(identifier: Identifiers.usingSafeArea, usesSafeArea: true)
     }

     /// A layout guide representing the inset for the keyboard.
     /// Use this layout guide’s top anchor to create constraints pinning to the top of the keyboard or the bottom of the view.
     public var keyboardLayoutGuideNoSafeArea: UILayoutGuide {
         getOrCreateKeyboardLayoutGuide(identifier: Identifiers.notUsingSafeArea, usesSafeArea: false)
     }

     private func getOrCreateKeyboardLayoutGuide(identifier: String, usesSafeArea: Bool) -> UILayoutGuide {
         if let existing = layoutGuides.first(where: { $0.identifier == identifier }) {
             return existing
         }
         let new = KeyboardLayoutGuide()
         new.usesSafeArea = usesSafeArea
         new.identifier = identifier
         addLayoutGuide(new)
         new.setUp()
         return new
     }
 }

 open class KeyboardLayoutGuide: UILayoutGuide {
     public var usesSafeArea = true {
         didSet {
             updateBottomAnchor()
         }
     }

     private var bottomConstraint: NSLayoutConstraint?

     @available(*, unavailable)
     public required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     public init(notificationCenter: NotificationCenter = NotificationCenter.default) {
         super.init()
         // Observe keyboardWillChangeFrame notifications
         notificationCenter.addObserver(
             self,
             selector: #selector(adjustKeyboard(_:)),
             name: UIResponder.keyboardWillChangeFrameNotification,
             object: nil
         )
         // Observe keyboardWillHide notifications
         notificationCenter.addObserver(
             self,
             selector: #selector(adjustKeyboard(_:)),
             name: UIResponder.keyboardWillHideNotification,
             object: nil
         )
     }

     internal func setUp() {
         guard let view = owningView else { return }
         NSLayoutConstraint.activate(
             [
                 heightAnchor.constraint(equalToConstant: Keyboard.shared.currentHeight),
                 leftAnchor.constraint(equalTo: view.leftAnchor),
                 rightAnchor.constraint(equalTo: view.rightAnchor),
             ]
         )
         updateBottomAnchor()
     }

     func updateBottomAnchor() {
         if let bottomConstraint = bottomConstraint {
             bottomConstraint.isActive = false
         }

         guard let view = owningView else { return }

         let viewBottomAnchor: NSLayoutYAxisAnchor
         if #available(iOS 11.0, *), usesSafeArea {
             viewBottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
         } else {
             viewBottomAnchor = view.bottomAnchor
         }

         bottomConstraint = bottomAnchor.constraint(equalTo: viewBottomAnchor)
         bottomConstraint?.isActive = true
     }

     @objc
     private func adjustKeyboard(_ note: Notification) {
         if var height = note.keyboardHeight, let duration = note.animationDuration {
             if #available(iOS 11.0, *), usesSafeArea, height > 0, let bottom = owningView?.safeAreaInsets.bottom {
                 height -= bottom
             }
             heightConstraint?.constant = height
             if duration > 0.0 {
                 animate(note)
             }
             Keyboard.shared.currentHeight = height
         }
     }

     private func animate(_ note: Notification) {
         if
             let owningView = self.owningView,
             isVisible(view: owningView)
         {
             self.owningView?.layoutIfNeeded()
         } else {
             UIView.performWithoutAnimation {
                 self.owningView?.layoutIfNeeded()
             }
         }
     }
 }

 // MARK: - Helpers

 extension UILayoutGuide {
     internal var heightConstraint: NSLayoutConstraint? {
         return owningView?.constraints.first {
             $0.firstItem as? UILayoutGuide == self && $0.firstAttribute == .height
         }
     }
 }

 extension Notification {
     var keyboardHeight: CGFloat? {
         guard let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
             return nil
         }

         if name == UIResponder.keyboardWillHideNotification {
             return 0.0
         } else {
             // Weirdly enough UIKeyboardFrameEndUserInfoKey doesn't have the same behaviour
             // in ios 10 or iOS 11 so we can't rely on v.cgRectValue.width
             let screenHeight = UIApplication.shared.keyWindow?.bounds.height ?? UIScreen.main.bounds.height
             return screenHeight - keyboardFrame.cgRectValue.minY
         }
     }

     var animationDuration: CGFloat? {
         return self.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat
     }
 }

 // Credits to John Gibb for this nice helper :)
 // https://stackoverflow.com/questions/1536923/determine-if-uiview-is-visible-to-the-user
 func isVisible(view: UIView) -> Bool {
     func isVisible(view: UIView, inView: UIView?) -> Bool {
         guard let inView = inView else { return true }
         let viewFrame = inView.convert(view.bounds, from: view)
         if viewFrame.intersects(inView.bounds) {
             return isVisible(view: view, inView: inView.superview)
         }
         return false
     }
     return isVisible(view: view, inView: view.superview)
 }

 */
