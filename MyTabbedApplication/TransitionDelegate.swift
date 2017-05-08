//
//  TransitionDelegate.swift
//  MyTabbedApplication
//
//  Created by sen.ke on 2017/5/8.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit

class TransitionDelegate: NSObject {
    static let shared = TransitionDelegate()
    
    private override init(){}
    
    // 转场动画
    lazy var transition: RevealTransition = {
        return RevealTransition()
    }()
    
    // 手势驱动
    var persentDrivenTransition: UIPercentDrivenInteractiveTransition?
}

extension TransitionDelegate: UIViewControllerTransitioningDelegate {
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
//        return persentDrivenTransition
//    }
    
//    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return persentDrivenTransition
//    }
}
