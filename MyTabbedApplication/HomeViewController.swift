//
//  HomeViewController.swift
//  MyTabbedApplication
//
//  Created by sen.ke on 2017/4/21.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit

import ReactiveCocoa
import ReactiveSwift

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Nav 左边按钮
        createLeftNavItem()
    }
    
    private func createLeftNavItem() {
        let leftBtn = UIButton(type: .custom)
        leftBtn.backgroundColor = UIColor.clear
        leftBtn.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0)
        leftBtn.setImage(UIImage(named: "Mine"), for: .normal)
        leftBtn.setImage(UIImage(named: "mineSelected"), for: .highlighted)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        leftBtn.reactive.controlEvents(.touchUpInside).observeValues({sender in
            
        })
    }
    
}
