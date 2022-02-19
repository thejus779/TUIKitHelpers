//
//  UINavigationController+Extensions.swift
//  
//
//  Created by Thejus Thejus on 29/12/2021.
//

import UIKit

public extension UINavigationController {
    func dismissWaitingForTransitionsIfAny(animated: Bool, completion: (() -> Void)?) {
        // Force waitForTransitionIfAny animated to true as other animations could be in progress
        waitForTransitionIfAny(animated: true) { [weak self] in
            if self?.presentedViewController != nil {
                // Double check, as first transition could have been a presenting
                // and a dismissing could already have been queued
                self?.waitForTransitionIfAny(animated: true) { [weak self] in
                    if self?.presentedViewController != nil {
                        // If no dismissing were in fact already called, then we can process it
                        self?.dismiss(animated: animated) {
                            completion?()
                        }
                    } else {
                        // Otherwise, it has alredy be done
                        completion?()
                    }
                }
            } else {
                completion?()
            }
        }
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        pushViewController(viewController, animated: animated)
        waitForTransitionIfAny(animated: animated, completion: completion)
    }
    
    func popViewController(animated: Bool, completion: (() -> Void)?) {
        popViewController(animated: animated)
        waitForTransitionIfAny(animated: animated, completion: completion)
    }
    func popToViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if viewControllers.contains(viewController) {
            popToViewController(viewController, animated: animated)
        }
        waitForTransitionIfAny(animated: animated, completion: completion)
    }
    func popToRootViewController(animated: Bool, completion: (() -> Void)?) {
        popToRootViewController(animated: animated)
        waitForTransitionIfAny(animated: animated, completion: completion)
    }
    
    private func waitForTransitionIfAny(animated: Bool, completion: (() -> Void)?) {
        guard animated else {
            completion?()
            return
        }
        if let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
}

public extension UINavigationController {
    convenience init(title: String? = nil, image: UIImage? = nil, selectedImage: UIImage? = nil) {
        self.init()
        tabBarItem.title = title
        tabBarItem.image = image
        tabBarItem.selectedImage = selectedImage
    }
}
