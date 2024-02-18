//
//  UserProfileViewController.swift
//  SwiftComponentExample
//
//  Created by Jingfu Li on 2024/2/18.
//

import UIKit
import SwiftComponent

class UserProfileViewController: UIViewController {

    lazy var tabelView = UITableView()

    lazy var dataSource = makeDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Me"
        view.backgroundColor = .white

        tabelView.delegate = self
        tabelView.dataSource = dataSource
        tabelView.translatesAutoresizingMaskIntoConstraints = false
        tabelView.separatorStyle = .none
        tabelView.register(Cell.self, forCellReuseIdentifier: NSStringFromClass(Cell.self))
        view.addSubview(tabelView)
        NSLayoutConstraint.activate([
            tabelView.topAnchor.constraint(equalTo: view.topAnchor),
            tabelView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabelView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tabelView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        loadData()
    }

    private func makeDataSource() -> DataSource {
        return DataSource(tableView: tabelView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(Cell.self), for: indexPath)
            if let cell = cell as? Cell {
                cell.titleLabel.text = itemIdentifier.title
            }

            return cell
        }
    }

    private func loadData() {
        let item = Item(title: "About")

        var snapshot = NSDiffableDataSourceSnapshot<String, Item>()
        snapshot.appendSections(["Root"])
        snapshot.appendItems([item], toSection: "Root")

        dataSource.apply(snapshot)
    }
}

extension UserProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UserProfileViewController {

    struct Item: Hashable {
        let title: String
    }
}

extension UserProfileViewController {

    class Cell: UITableViewCell {

        let titleLabel = Label()

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(titleLabel)
            NSLayoutConstraint.activate([
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

extension UserProfileViewController {

    class DataSource: UITableViewDiffableDataSource<String, Item> {
    }
}
