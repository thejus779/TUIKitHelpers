//
//  UIView+Shadows.swift
//  
//
//  Created by Thejus Thejus on 19/02/2022.
//

import Foundation
import UIKit

// Either use shadow style or user add bottom shadows
public extension UIView {
    
    func removeBottomShadow() {
        layer.shadowColor = nil
        layer.shadowOpacity = 0
        layer.shadowOffset = .zero
        layer.shadowRadius = 0
        layer.shadowPath = nil
    }
    
    func addBottomShadow(opacity: Float = 0.15, offset: CGSize = CGSize(width: 0, height: 3), radius: CGFloat = 2, color: CGColor = UIColor.black.cgColor) {
        layer.shadowColor = color
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.masksToBounds = false
        layer.shadowRadius = radius
    }
    // Update shadowpaths in layoutsubviews
    func updateShadowPath(radius: CGFloat? = nil, corners: UIRectCorner? = nil) {
        guard layer.shadowOpacity > 0, layer.shadowColor != nil else {
            print("[UIView+Shadow] Warning, attempting to setup shadow with opacity == 0 or shadowColor = nil")
            return
        }
        
        if let radius = radius {
            if let corners = corners {
                layer.shadowPath = UIBezierPath(
                    roundedRect: bounds,
                    byRoundingCorners: corners,
                    cornerRadii: CGSize(width: radius, height: radius)
                ).cgPath
            } else {
                layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
            }
        } else {
            layer.shadowPath = CGPath(rect: bounds, transform: nil)
        }
    }
    func addRoundedCorners(radius: CGFloat, corners: UIRectCorner, color: UIColor = .white, opacity: Float = 1.0) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = frame
        rectShape.position = center
        rectShape.path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        ).cgPath

        layer.backgroundColor = color.cgColor
        layer.opacity = opacity
        layer.mask = rectShape
    }
    func removeRoundedCorners() {
        layer.mask = nil
    }
}

public struct ShadowStyle {
    let opacity: Float
    let offset: CGFloat
    let radius: CGFloat
    
    var upsideDown: ShadowStyle {
        return ShadowStyle(opacity: opacity, offset: -offset, radius: radius)
    }
}

// Either use shadow style or user add bottom shadows

public extension UIView {
    struct DefaultShadows {
        let defaultBig = ShadowStyle(opacity: 0.1, offset: 3, radius: 7)
        let defaultMedium = ShadowStyle(opacity: 0.15, offset: 3, radius: 5)
    }
    
    var shadowStyle: ShadowStyle {
        get {
            return ShadowStyle(opacity: self.layer.shadowOpacity,
                               offset: self.layer.shadowOffset.height,
                               radius: self.layer.shadowRadius)
        }
        set {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = newValue.opacity
            self.layer.shadowOffset = CGSize(width: 0, height: newValue.offset)
            self.layer.shadowRadius = newValue.radius
        }
    }
}
