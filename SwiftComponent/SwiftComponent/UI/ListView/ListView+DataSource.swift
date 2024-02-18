//
//  ListView+DataSource.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/2/18.
//

import UIKit

public protocol ListViewSection {
    var rows: [ListViewRow] { get set }
}

public protocol ListViewHeader {
}

public protocol ListViewFooter {
}

public protocol ListViewRow {
    var cellClass: AnyClass { get set }
}

public protocol ListViewUpdate {
    func update(_ row: ListViewRow)
}
