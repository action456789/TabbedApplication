//
//  RevealTransition.swift
//  MyTabbedApplication
//
//  Created by sen.ke on 2017/5/5.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit

class RevealTransition: NSObject {
    let ScreenWidth = UIScreen.main.bounds.width
    let ScreenHeight = UIScreen.main.bounds.height
    
    // 主页，相对于侧边控制器
    var homeVC: UIViewController?
    
    let ratio = CGFloat(0.7)
    var x: CGFloat {
        return ScreenWidth * ratio
    }
    
    lazy var maskView: UIView = {
        let maskView = UIView(frame: CGRect(x: 0, y: 0, width: self.ScreenWidth, height: self.ScreenHeight))
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0
        maskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.maskViewTap)))
        return maskView
    }()
    
    @objc private func maskViewTap() {
        homeVC?.dismiss(animated: true, completion: nil)
    }
}

extension RevealTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let destinationVC = transitionContext.viewController(forKey: .to)
        if destinationVC?.isBeingPresented == true {
            present(context: transitionContext)
        } else {
            dismiss(context: transitionContext)
        }
    }
    
    private func present(context: UIViewControllerContextTransitioning) {
        guard let fromVC = context.viewController(forKey: .from) else {
            context.completeTransition(true)
            return
        }
        
        guard let toVC = context.viewController(forKey: .to) else {
            context.completeTransition(true)
            return
        }
        
        homeVC = fromVC
        
        // 添加遮盖
        UIApplication.shared.keyWindow?.addSubview(maskView)
        
        // 需要主动将 toVC.view 加入容器
        context.containerView.addSubview(toVC.view)
        
        // 初始时的位置
        toVC.view.frame = CGRect(x: -ScreenWidth, y: 0, width: ScreenWidth, height: ScreenHeight)
        
        let duration = transitionDuration(using: context)
        
        // 动画
        UIView.animate(withDuration: duration, delay: 0, options: .layoutSubviews, animations: { 
            toVC.view.transform = CGAffineTransform(translationX: self.x, y: 0)
            fromVC.view.transform = CGAffineTransform(translationX: self.x, y: 0)
            self.maskView.transform = CGAffineTransform(translationX: self.x, y: 0)
            self.maskView.alpha = 0.5
        }) { (_) in
            context.completeTransition(true)
        }
    }
    
    private func dismiss(context: UIViewControllerContextTransitioning) {
        // 注意：此时的 fromVC 与 present函数中的正好相反
        guard let fromVC = context.viewController(forKey: .from) else { return }
        guard let toVC = context.viewController(forKey: .to) else { return }
        
        context.containerView.bringSubview(toFront: fromVC.view)
        
        let duration = transitionDuration(using: context)
        
        UIView.animate(withDuration: duration, delay: 0, options: .layoutSubviews, animations: {
            toVC.view.transform = CGAffineTransform.identity
            fromVC.view.transform = CGAffineTransform.identity
            self.maskView.transform = CGAffineTransform.identity
            self.maskView.alpha = 0
        }) { (_) in
            self.maskView.removeFromSuperview()
            context.completeTransition(true)
        }
    }
}
