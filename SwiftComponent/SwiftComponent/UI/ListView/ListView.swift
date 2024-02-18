//
//  ListView.swift
//  SwiftComponent
//
//  Created by Jingfu Li on 2024/2/18.
//

import UIKit

open class ListView: UIView {

    private let tableView = UITableView(frame: .zero, style: .plain)

    open var sections = [ListViewSection]() {
        didSet {
            tableView.reloadData()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListView: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListView: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        tableView.register(row.cellClass, forCellReuseIdentifier: NSStringFromClass(row.cellClass))

        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(row.cellClass), for: indexPath)
        if let cell = cell as? ListViewUpdate {
            cell.update(row)
        }

        return cell
    }
}
