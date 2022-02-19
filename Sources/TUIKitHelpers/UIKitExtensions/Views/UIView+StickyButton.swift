//
//  UIView+StickyButton.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    
    private static let stickyTag = 157843
    
    func appendStickyButton(button: UIButton, underView: UIView, buttonHeight: CGFloat = 50) {
        let viewContainer = UIView()
        addSubview(viewContainer)
        viewContainer.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        viewContainer.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(buttonHeight)
            make.top.equalToSuperview()
            if #available(iOS 11, *) {
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
            } else {
                make.bottom.equalTo(self)
            }
        }

        underView.snp.makeConstraints { (make) in
            make.bottom.equalTo(viewContainer.snp.top)
        }
        
        button.tag = UIView.stickyTag
    }
    
    @discardableResult
    func appendStickyButton(with text: String, underView: UIView) -> StickyButton {
        let button = createStickyButton(with: text)
        appendStickyButton(button: button, underView: underView)
        stickyButtonEnabled = true
        return button
    }
    
    func removeStickyButton(underView: UIView) {
        guard let button = viewWithTag(UIView.stickyTag) as? UIButton else { return }
        guard let buttonContainer = button.superview else { return }
        buttonContainer.removeFromSuperview()
        underView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
            } else {
                make.bottom.equalTo(self)
            }
        }
    }
    
    private func createStickyButton(with text: String) -> StickyButton {
        let button = StickyButton(type: .system)
        button.setup()
        button.setTitle(text, for: .normal)
        return button
    }
    
    var stickyButtonEnabled: Bool {
        get {
            guard let button = self.viewWithTag(UIView.stickyTag) as? UIButton else { return false }
            return button.isEnabled
        }
        set {
            guard let button = self.viewWithTag(UIView.stickyTag) as? UIButton else { return }
            button.isEnabled = newValue
            button.superview?.backgroundColor = button.backgroundColor
        }
    }
    
    var stickyButton: StickyButton? {
        return self.viewWithTag(UIView.stickyTag) as? StickyButton
    }
    
    @discardableResult
    func appendStickyButtons(with texts: [String], underView: UIView, buttonHeight: CGFloat = 50, containerBackgroundColor: UIColor = .white, sepratorSpacing: CGFloat = 0) -> [StickyButton] {
        let buttons = texts.map({ createStickyButton(with: $0) })
        
        let container = UIView()
        addSubview(container)
        container.snp.makeConstraints({
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(underView.snp.bottom)
        })
        container.backgroundColor = containerBackgroundColor
        
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = sepratorSpacing
        container.addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(buttonHeight)
            make.top.equalToSuperview()
            if #available(iOS 11, *) {
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
            } else {
                make.bottom.equalTo(self)
            }
        }
        return buttons
    }
}
