//
//  AnimationController.swift
//  TabBarInsideNavigationController
//
//  Created by Nguyen Quoc Dat on 26/3/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning,
                           UINavigationControllerDelegate, UITabBarControllerDelegate {
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    // MARK: - UITabBarDelegate
    
    func tabBarController(_ tabBarController: UITabBarController,
                          animationControllerForTransitionFrom fromVC: UIViewController,
                          to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // This doesn't really help with the tab-bar-sliding-out behaviour when we push something new
        return self
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to) else {
                return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        let fromViewFrame = containerView.convert(fromView.bounds, from: fromView)
        let toViewFrame = CGRect(origin: CGPoint(x: fromViewFrame.minX, y: fromViewFrame.maxY),
                                 size: fromViewFrame.size)
        toView.frame = toViewFrame
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
                        toView.frame = fromViewFrame
        }) { didComplete in
            transitionContext.completeTransition(didComplete)
        }
    }
    
    
}
