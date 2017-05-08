//
//  HomeViewController.swift
//  MyTabbedApplication
//
//  Created by sen.ke on 2017/4/21.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // 左边控制器
    lazy var leftVC: LeftViewController = {
        let leftVC =  LeftViewController.init(nibName: nil, bundle: nil)
        
        leftVC.transitioningDelegate = TransitionDelegate.shared
        leftVC.modalPresentationCapturesStatusBarAppearance = true
        leftVC.modalPresentationStyle = .custom
        
        return leftVC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Nav 左边按钮
        createLeftNavItem()

        self.transitioningDelegate = TransitionDelegate.shared
        self.modalPresentationCapturesStatusBarAppearance = true
        self.modalPresentationStyle = .custom

        // 添加侧滑手势
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.edgePanGesture(edgePan:)))
        edgePan.edges = UIRectEdge.left
        view.addGestureRecognizer(edgePan)
    }
    
    @objc private func edgePanGesture(edgePan: UIScreenEdgePanGestureRecognizer) {
        let progress = edgePan.translation(in: self.view).x / self.view.bounds.width
        print(progress)
        
        if edgePan.state == .began {
            TransitionDelegate.shared.persentDrivenTransition = UIPercentDrivenInteractiveTransition()
            self.tabBarController?.present(self.leftVC, animated: true, completion: nil)
            
        } else if edgePan.state == .changed {
            TransitionDelegate.shared.persentDrivenTransition?.update(progress)
            
        } else if edgePan.state == .cancelled || edgePan.state == .ended {
            if progress > 0.5 {
                TransitionDelegate.shared.persentDrivenTransition?.finish()
            } else {
                TransitionDelegate.shared.persentDrivenTransition?.cancel()
            }
            TransitionDelegate.shared.persentDrivenTransition = nil
        }
    }
    
    private func createLeftNavItem() {
        let leftBtn = UIButton(type: .custom)
        leftBtn.backgroundColor = UIColor.clear
        leftBtn.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0)
        leftBtn.setImage(UIImage(named: "Mine"), for: .normal)
        leftBtn.setImage(UIImage(named: "mineSelected"), for: .highlighted)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        // 按钮点击事件
        leftBtn.addTarget(self, action: #selector(self.buttonClick), for: .touchUpInside)
    }
    
    func buttonClick() {
        self.tabBarController?.present(self.leftVC, animated: true, completion: nil)
    }
}
