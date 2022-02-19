//
//  UIView+Toaster.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation
import UIKit

extension UIView {
    private static let toasterViewTag = 87861542
    
    func showToaster(message: String,
                     duration: TimeInterval = 3.0,
                     style: ToasterView.Style = .error,
                     completion: VoidBlock? = nil) {
        guard let window = UIApplication.shared.keyWindow else { return }
        if window.viewWithTag(UIView.toasterViewTag) != nil {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            dismissToaster { [weak self] in
                self?.showToaster(message: message, duration: duration)
            }
            return
        }
        let toaster = ToasterView()
        toaster.tag = UIView.toasterViewTag
        window.addSubview(toaster)
        toaster.style = style
        
        toaster.label.text = message
        
        let offset = UIApplication.shared.statusBarFrame.height
        toaster.container.snp.updateConstraints { (update) in
            update.top.equalToSuperview().offset(offset)
        }
        toaster.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        toaster.layoutIfNeeded()
        
        toaster.transform = CGAffineTransform(translationX: 0, y: -toaster.bounds.size.height)
        
        UIView.animate(withDuration: AppStyle.animationDurations.expand,
                       delay: 0,
                       options: [.allowUserInteraction, .curveEaseIn],
                       animations: {
                        toaster.transform = CGAffineTransform.identity
        }, completion: { [weak self] (finished) in
            if finished {
                self?.perform(#selector(self?.dismissToasterWithCompletion), with: completion, afterDelay: duration)
            }
        })
    
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissToasterNoCompletion))

        swipeRecognizer.direction = .up
        toaster.addGestureRecognizer(swipeRecognizer)
    }
    
    func dismissToaster(completion: VoidBlock?) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        dismissToaster(completion: completion)
    }
    
    func hasToaster() -> Bool {
        return UIApplication.shared.keyWindow?.viewWithTag(UIView.toasterViewTag) != nil
    }
    
    @objc private func dismissToasterNoCompletion() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        dismissToaster(completion: nil)
    }
    
    @objc private func dismissToasterWithCompletion(arg: Any) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        let completion = arg as? VoidBlock
        dismissToaster(completion: completion)
    }

    @objc private func dismissToaster(completion: VoidBlock?) {
        guard let toaster = UIApplication.shared.keyWindow?.viewWithTag(UIView.toasterViewTag) else { return }
        
        UIView.animate(withDuration: AppStyle.animationDurations.expand,
                       delay: 0,
                       options: [.allowUserInteraction, .curveEaseOut],
                       animations: {
                        toaster.transform = CGAffineTransform(translationX: 0, y: -toaster.bounds.size.height)
        }, completion: { (finished) in
            if finished {
                toaster.removeFromSuperview()
                completion?()
            }
        })
    }
}
