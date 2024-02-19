//
//  ListView+DataSource.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/2/18.
//

import UIKit

public protocol ListViewSection {
    var header: ListViewHeader? { get set }
    var footer: ListViewFooter? { get set }
    var rows: [ListViewRow] { get set }
}

public protocol ListViewHeader {
    var headerClass: AnyClass { get set }
    var height: CGFloat { get set }
}

public protocol ListViewFooter {
    var footerClass: AnyClass { get set }
    var height: CGFloat { get set }
}

public protocol ListViewRow {
    var cellClass: AnyClass { get set }
    var height: CGFloat { get set }
}

public protocol ListViewUpdate {
    func update(_ row: ListViewRow)
}
