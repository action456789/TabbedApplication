//
//  MyTabBarController.swift
//  MyTabbedApplication
//
//  Created by sen.ke on 2017/4/21.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildViewControllers()
    }
    
    private func setupChildViewControllers() {
        let home = HomeViewController(nibName: nil, bundle: nil)
        setupChildViewController(childVc: home, title: "首页", imageName: "homeNomal", selectedImageName: "homeSelected")
        
        let explore = ExploreViewController(nibName: nil, bundle: nil)
        setupChildViewController(childVc: explore, title: "发现", imageName: "bottomXD", selectedImageName: "newsSelected")
        
        let mine = MineViewController(nibName: nil, bundle: nil)
        setupChildViewController(childVc: mine, title: "我的", imageName: "Mine", selectedImageName: "mineSelected")
        
    }
    
    private func setupChildViewController(childVc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)
        childVc.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)

        let nav = UINavigationController(rootViewController: childVc)
        addChildViewController(nav)
    }
}
