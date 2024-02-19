//
//  TextNode.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/2/19.
//

import Foundation

public protocol BaseTextNode {
    var key: String { get }
    var painText: String { get }
    var parent: BaseTextNode? { get }
    var children: [BaseTextNode]? { get }
}

public extension BaseTextNode {
    var key: String { "\(UUID())" }
    var painText: String { "" }
    var parent: BaseTextNode? { nil }
    var children: [BaseTextNode]? { nil }
}

public final class TextNode: BaseTextNode {

    var attributedString: NSAttributedString?

}

public final class ImageNode: BaseTextNode {

}
