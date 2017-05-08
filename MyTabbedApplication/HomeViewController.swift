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
        
        leftVC.transitioningDelegate = self
        leftVC.modalPresentationCapturesStatusBarAppearance = true
        leftVC.modalPresentationStyle = .custom
        
        return leftVC
    }()
    
    // 转场动画
    lazy var transition: RevealTransition = {
        return RevealTransition()
    }()
    
    // 手势驱动
    var persentDrivenTransition: UIPercentDrivenInteractiveTransition?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Nav 左边按钮
        createLeftNavItem()

        self.transitioningDelegate = self
        self.modalPresentationCapturesStatusBarAppearance = true
        self.modalPresentationStyle = .custom

        // 添加手势
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.edgePanLeft(edgePan:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func edgePanLeft(edgePan: UIScreenEdgePanGestureRecognizer) {
        let progress = edgePan.translation(in: self.view).x / self.view.bounds.width
        print(progress)
        
        if edgePan.state == .began {
            persentDrivenTransition = UIPercentDrivenInteractiveTransition()
            self.tabBarController?.present(self.leftVC, animated: true, completion: nil)
            
        } else if edgePan.state == .changed {
            persentDrivenTransition?.update(progress)
            
        } else if edgePan.state == .cancelled || edgePan.state == .ended {
            if progress > 0.5 {
                persentDrivenTransition?.finish()
            } else {
                persentDrivenTransition?.cancel()
            }
            
            persentDrivenTransition = nil
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

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MyPresentaionController(presentedViewController: presented, presenting: presenting)
    }
    
    // 自定义 present
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    // 自定义 dismiss
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    // 手势驱动
    //    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    //        if animator.isKind(of: RevealTransition.self)  {
    //            return persentDrivenTransition
    //        }
    //        return nil
    //    }
    
//    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        if animator.isKind(of: RevealTransition.self)  {
//            return persentDrivenTransition
//        }
//        return nil
//    }
}
