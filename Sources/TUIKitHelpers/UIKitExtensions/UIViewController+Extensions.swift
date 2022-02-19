//
//  UIViewController+Extensions.swift
//  
//
//  Created by Thejus Thejus on 13/12/2021.
//

import UIKit

public extension UIViewController {
    func inNavigationController() -> UINavigationController {
        let nc = UINavigationController(rootViewController: self)
        nc.navigationBar.prefersLargeTitles = true
        return nc
    }
    
    @discardableResult
    func withModalPresentationStyle(_ mps: UIModalPresentationStyle) -> Self {
        self.modalPresentationStyle = mps
        return self
    }
    
    @discardableResult
    func withTabBarItem(title: String? = nil, image: UIImage? = nil, selectedImage: UIImage? = nil) -> Self {
        tabBarItem.title = title
        tabBarItem.image = image
        tabBarItem.selectedImage = selectedImage
        return self
    }
    
    @discardableResult
    func withNavigationItem(title: String? = nil, left: [UIBarButtonItem]? = nil, right: [UIBarButtonItem]? = nil) -> Self {
        navigationItem.title = title
        navigationItem.leftBarButtonItems = left
        navigationItem.rightBarButtonItems = right
        return self
    }
    
    @discardableResult
    func withDoneButton(_ target: Any?, _ action: Selector?) -> Self {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: target, action: action)
        return self
    }
    
    func firstParent<T>(ofKind kind: T.Type) -> T? {
        let nearest = parent ?? navigationController ?? tabBarController ?? presentingViewController
        return (nearest as? T) ?? nearest?.firstParent(ofKind: T.self)
    }
    
    static func dummy(title: String? = nil, image: UIImage? = nil, selectedImage: UIImage? = nil) -> UIViewController {
        let instance = UIViewController(nibName: nil, bundle: nil)
        if #available(iOS 13.0, *) {
            instance.view.backgroundColor = .systemBackground
        } else {
            instance.view.backgroundColor = .white
        }
        instance.navigationItem.title = title
        instance.tabBarItem.title = title
        instance.tabBarItem.image = image
        instance.tabBarItem.selectedImage = selectedImage
        return instance
    }
}

public extension UIViewController {
    /// See https://stackoverflow.com/a/38272014/2219009
    /// TL;DR: Use this in didAppear or willAppear.
    /// Only works on standard navigation (push or present)
    var didOrWillAppearOnce: Bool {
        return !isBeingPresented && !isMovingToParent
    }
    
    internal func popToSelf(completion: (() -> Void)? = nil) {
        if  let fullScreenNavController = tabBarController?.navigationController,
            fullScreenNavController.viewControllers.last != tabBarController {
            // Something is above tabBar, popping any controllers above self, then pop to tabBar
            navigationController?.popToViewController(self, animated: false) {
                fullScreenNavController.popToRootViewController(animated: true, completion: completion)
            }
        } else {
            // TabBarController is on top, thus self is rootViewController
            navigationController?.popToViewController(self, animated: true, completion: completion)
        }
    }
    // TODO:- Remove if not needed anymore
    static func topViewController() -> UIViewController? {
        guard let window = UIWindow.keyWindow() else {
            LOG("[UIViewController] Cannot find the key window")
            return nil
        }
        let root = window.rootViewController
        return UIViewController.topViewController(withRootController: root)
    }
    
    /// Recursively lookup the top controller starting from a root view controller
    /// - Parameter controller: The root view controller
    /// - Returns: The top view controller
    private static func topViewController(withRootController controller: UIViewController?) -> UIViewController? {
        if controller is UITabBarController {
            let vc = (controller as? UITabBarController)?.selectedViewController
            return self.topViewController(withRootController: vc)
        }
        if controller is UINavigationController {
            let vc = (controller as? UINavigationController)?.visibleViewController
            return self.topViewController(withRootController: vc)
        }
        guard let presented = controller?.presentedViewController  else {
            return controller
        }
        return self.topViewController(withRootController: presented)
    }
}
