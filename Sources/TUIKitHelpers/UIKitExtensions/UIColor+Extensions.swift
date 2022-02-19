//
//  UIColor+Extensions.swift
//  
//
//  Created by Thejus Thejus on 29/12/2021.
//

import UIKit

/**
 * Used to create color from hex
 */
public extension UIColor {
    
    
    /// Create color with values O..255
    ///
    /// - Parameters:
    ///   - red: red value
    ///   - green: green value
    ///   - blue: blue value
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    
    /// Create color from hex value: 0xRRGGBB
    ///
    /// - Parameter hex: hex value
    convenience init(hex: Int) {
        self.init(red: (hex >> 16) & 0xFF, green: (hex >> 8) & 0xFF, blue: (hex) & 0xFF)
    }
    
    /// Used to create UIImage from UIColor
    ///
    /// - Parameter size: size of the image
    /// - Returns: UIImage instance
    func imageRepresentation(with size: CGSize = .init(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func addColor(_ overlay: UIColor) -> UIColor {
        var bgR: CGFloat = 0
        var bgG: CGFloat = 0
        var bgB: CGFloat = 0
        var bgA: CGFloat = 0
        
        var fgR: CGFloat = 0
        var fgG: CGFloat = 0
        var fgB: CGFloat = 0
        var fgA: CGFloat = 0
        
        getRed(&bgR, green: &bgG, blue: &bgB, alpha: &bgA)
        overlay.getRed(&fgR, green: &fgG, blue: &fgB, alpha: &fgA)
        
        let r = fgA * fgR + (1 - fgA) * bgR
        let g = fgA * fgG + (1 - fgA) * bgG
        let b = fgA * fgB + (1 - fgA) * bgB
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

