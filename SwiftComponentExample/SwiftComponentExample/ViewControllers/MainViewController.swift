//
//  MainViewController.swift
//  SwiftComponentExample
//
//  Created by Jingfu Li on 2024/2/18.
//

import UIKit
import SwiftComponent

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MainViewController.LifecycleNotification.viewWillAppear.post(parameter: animated)
    }
}

extension MainViewController {
    enum LifecycleNotification: String, ZNotification.Notifiable {
        typealias ParameterType = Bool

        case viewWillAppear
    }
}


