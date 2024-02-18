//
//  ViewController.swift
//  SwiftComponentExample
//
//  Created by Jingfu Li on 2024/2/18.
//

import UIKit
import SwiftComponent

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = Label()
        label.text = "Hi!\nMM"
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


}

