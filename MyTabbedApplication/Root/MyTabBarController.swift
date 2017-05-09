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
        setupChildViewController(childVc: home, title: "首页", imageName: "home_normal", selectedImageName: "home_select")
        
        let livingRoom = LivingRoomViewController(nibName: nil, bundle: nil)
        setupChildViewController(childVc: livingRoom, title: "房间", imageName: "room_normal", selectedImageName: "room_select")
        
        let voice = VoiceViewController(nibName: nil, bundle: nil)
        setupChildViewController(childVc: voice, title: "语音", imageName: "voice_normal", selectedImageName: "voice_select")
        
        let scenes = ScenesViewController(nibName: nil, bundle: nil)
        setupChildViewController(childVc: scenes, title: "场景", imageName: "scenes_normal", selectedImageName: "scenes_select")
        
        let setting = SettingViewController(nibName: nil, bundle: nil)
        setupChildViewController(childVc: setting, title: "设置", imageName: "setting_normal", selectedImageName: "setting_select")
    }
    
    private func setupChildViewController(childVc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)
        childVc.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)

        let nav = UINavigationController(rootViewController: childVc)
        addChildViewController(nav)
    }
}
