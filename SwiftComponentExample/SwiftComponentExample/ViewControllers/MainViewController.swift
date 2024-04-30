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
            UINavigationController(rootViewController: AudioViewController()),
            UINavigationController(rootViewController: UserProfileViewController()),
            UINavigationController(rootViewController: DetailViewController()),
        ]

        let audioItem: UITabBarItem? = tabBar.items?[0]
        audioItem?.title = "Audio"
        audioItem?.image = UIImage(systemName: "airpodsmax")

        let meItem: UITabBarItem? = tabBar.items?[1]
        meItem?.title = "Me"
        meItem?.image = UIImage(systemName: "house.circle.fill")

        let detailItem: UITabBarItem? = tabBar.items?[2]
        detailItem?.title = "Detail"
        detailItem?.image = UIImage(systemName: "doc.richtext.zh")
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


