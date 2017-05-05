//
//  RootViewController.swift
//  MyTabbedApplication
//
//  Created by sen.ke on 2017/5/5.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    open lazy var contentView: UIView = {
        return UIView(frame: self.view.bounds)
    }()
    
    open lazy var maskView: UIView = {
        let maskView = UIView(frame: self.view.bounds)
        maskView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        maskView.isHidden = true
        
        return maskView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(contentView)
        view.addSubview(maskView)
    }
}
