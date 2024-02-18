//
//  MainViewController.swift
//  SwiftComponentExample
//
//  Created by Jingfu Li on 2024/2/18.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            UINavigationController(rootViewController: UserProfileViewController())
        ]

        let meItem: UITabBarItem? = tabBar.items?[0]
        meItem?.title = "Me"
        meItem?.image = UIImage(systemName: "house.circle.fill")
    }
}
