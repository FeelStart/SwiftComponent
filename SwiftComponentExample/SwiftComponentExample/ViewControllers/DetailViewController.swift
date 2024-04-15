//
//  DetailViewController.swift
//  SwiftComponentExample
//
//  Created by Jingfu Li on 2024/4/15.
//

import UIKit

class DetailViewController: UIViewController {

    let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Detail"
        view.backgroundColor = .white

        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 20
        paragraphStyle.tailIndent = 20

        var attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "惊蛰一过，春寒加剧。\n",
                                                   attributes: [
                                                    .font: UIFont.boldSystemFont(ofSize: 20),
                                                    .foregroundColor: UIColor.black]))
        attributedString.append(NSAttributedString(string: "先是料料峭峭，继而雨季开始，时而淋淋漓漓，时而淅淅沥沥，天潮潮地湿湿，即连在梦里，也似乎有把伞撑着。\n",
                                                   attributes: [
                                                    .font: UIFont.systemFont(ofSize: 15),
                                                    .backgroundColor: UIColor.red,
                                                    .foregroundColor: UIColor.black]))
        attributedString.append(NSAttributedString(string: "连思想也都是潮润润的。每天回家，曲折穿过金门街到厦门街迷宫式的长巷短巷，雨里风里，走入霏霏令人更想入非非。",
                                                   attributes: [
                                                    .font: UIFont.systemFont(ofSize: 15),
                                                    .strokeColor: UIColor.black,
                                                    .strokeWidth: 4,
                                                    .paragraphStyle: paragraphStyle,
                                                    .backgroundColor: UIColor.green,
                                                    .foregroundColor: UIColor.black]))


        textView.attributedText = attributedString
    }

}
