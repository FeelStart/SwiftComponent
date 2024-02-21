//
//  ViewController.swift
//  TextViewExample
//
//  Created by Jingfu Li on 2024/2/20.
//

import UIKit
import SwiftComponent

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initTextView()
    }

    private func initTextView() {
        let textView = LabelView()
        textView.text = "Hi!\nHa\nend"
        textView.backgroundColor = .red
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textView.widthAnchor.constraint(equalToConstant: 300),
            textView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

