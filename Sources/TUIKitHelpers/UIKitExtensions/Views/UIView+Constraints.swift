//
//  UIView+Constraints
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation
import UIKit

/**
 * Used to create constraint by code
 * Add view to its subview before calling those functions
 */
extension UIView {

    /// Returns (top, leading, bottom, trailing) constraints
    @discardableResult
    func addSubviewStuckedToAnchors(view: UIView, insets: UIEdgeInsets = .zero, heightConstant: CGFloat? = nil) -> (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint?) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top)
        let leadingConstraint = view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left)
        let trailingConstraint = view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
        let bottomConstraints = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        addConstraints([
            topConstraint,
            leadingConstraint,
            trailingConstraint,
            bottomConstraints
        ])
        var heightConstraint: NSLayoutConstraint?
        if let heightConstant = heightConstant {
            let constraint = view.heightAnchor.constraint(equalToConstant: heightConstant)
            heightConstraint = constraint
            addConstraint(constraint)
        }
        return (topConstraint, leadingConstraint, bottomConstraints, trailingConstraint, heightConstraint)
    }
    /// Returns (top, leading, bottom, trailing) constraints
    @discardableResult
    func addSubviewStuckedToTop(view: UIView, height: CGFloat? = nil, insets: UIEdgeInsets = .zero) -> (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint?) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top)
        let leadingConstraint = view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left)
        let trailingConstraint = view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
        
        let heightConstraint: NSLayoutConstraint?
        if let height = height {
            heightConstraint = view.heightAnchor.constraint(equalToConstant: height)
            heightConstraint?.isActive = true
        } else {
            heightConstraint = nil
        }
        addConstraints([
            topConstraint,
            leadingConstraint,
            trailingConstraint
        ])
        return (topConstraint, leadingConstraint, trailingConstraint, heightConstraint)
    }

    /// Returns (bottom, leading, trailing, height) constraints
    @discardableResult
    func addSubviewStuckedToBottom(view: UIView, height: CGFloat? = nil, insets: UIEdgeInsets = .zero) -> (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint?) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        let leadingConstraint = view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left)
        let trailingConstraint = view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
        
        let heightConstraint: NSLayoutConstraint?
        if let height = height {
            heightConstraint = view.heightAnchor.constraint(equalToConstant: height)
            heightConstraint?.isActive = true
        } else {
            heightConstraint = nil
        }
        addConstraints([
            bottomConstraint,
            leadingConstraint,
            trailingConstraint
        ])
        return (bottomConstraint, leadingConstraint, trailingConstraint, heightConstraint)
    }
    
    /// Returns (top, leading, bottom, height) constraints
    @discardableResult
    func addSubviewStuckedToTopLeadingBottom(view: UIView, height: CGFloat? = nil, insets: UIEdgeInsets = .zero) -> (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint?) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top)
        let leadingConstraint = view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left)
        let bottomConstraint = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.left)
        
        let heightConstraint: NSLayoutConstraint?
        if let height = height {
            heightConstraint = view.heightAnchor.constraint(equalToConstant: height)
            heightConstraint?.isActive = true
        } else {
            heightConstraint = nil
        }
        addConstraints([
            topConstraint,
            leadingConstraint,
            bottomConstraint
        ])
        return (topConstraint, leadingConstraint, bottomConstraint, heightConstraint)
    }
    
    /// Returns (bottom, trailing, width, height) constraints
    @discardableResult
    func addSubviewStuckedToBottomTrailing(view: UIView, size: CGSize, insets: UIEdgeInsets = .zero) -> (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        let trailingConstraint = view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
        let widthConstraint = view.widthAnchor.constraint(equalToConstant: size.width)
        let heightConstraint = view.widthAnchor.constraint(equalToConstant: size.height)
        addConstraints([
            bottomConstraint,
            trailingConstraint,
            widthConstraint,
            heightConstraint
        ])
        return (bottomConstraint, trailingConstraint, widthConstraint, heightConstraint)
    }


    /// Add top, bottom, left and right constraints with a value of
    ///
    /// - Parameters:
    ///   - top
    ///   - left
    ///   - bottom
    ///   - right
    /// - Returns: Array of the 4 constraints
    @discardableResult func addSpacingConstraints(top: CGFloat,
                                                  left: CGFloat,
                                                  bottom: CGFloat,
                                                  right: CGFloat) -> [NSLayoutConstraint] {
        var originC = addOriginConstraints(top: top, left: left)
        let bottomC = addBottomConstraint(bottom)
        let rightC = addRightConstraint(right)

        if let bottomC = bottomC {
            originC.append(bottomC)
        }
        if let rightC = rightC {
            originC.append(rightC)
        }
        return originC
    }


    /// Add top, left constraints with a value of
    ///
    /// - Parameters:
    ///   - top
    ///   - left
    /// - Returns: Array of 2 constraints
    @discardableResult func addOriginConstraints(top: CGFloat,
                                                 left: CGFloat) -> [NSLayoutConstraint] {
        guard let superview = superview else {
            return []
        }
        translatesAutoresizingMaskIntoConstraints = false
        let topC = NSLayoutConstraint(item: self,
                                      attribute: .top,
                                      relatedBy: .equal,
                                      toItem: superview,
                                      attribute: .top,
                                      multiplier: 1.0,
                                      constant: top)
        superview.addConstraint(topC)

        var result = [topC]
        if let leftC = addLeftConstraint(left) {
            result.append(leftC)
        }
        return result
    }

    @discardableResult func addBottomConstraint(_ constant: CGFloat) -> NSLayoutConstraint? {
        guard let superview = superview else {
            return nil
        }
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: superview,
                                            attribute: .bottom,
                                            multiplier: 1.0,
                                            constant: -constant)
        superview.addConstraint(constraint)

        return constraint
    }

    @discardableResult func addLeftConstraint(_ constant: CGFloat) -> NSLayoutConstraint? {
        guard let superview = superview else {
            return nil
        }
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .leading,
                                            relatedBy: .equal,
                                            toItem: superview,
                                            attribute: .leading,
                                            multiplier: 1.0,
                                            constant: constant)
        superview.addConstraint(constraint)

        return constraint
    }

    @discardableResult func addRightConstraint(_ constant: CGFloat) -> NSLayoutConstraint? {
        guard let superview = superview else {
            return nil
        }
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: superview,
                                            attribute: .trailing,
                                            multiplier: 1.0,
                                            constant: -constant)
        superview.addConstraint(constraint)

        return constraint
    }

}
