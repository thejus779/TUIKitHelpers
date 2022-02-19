//
//  UIButton+Extensions.swift
//
//
//  Created by Thejus Thejus on 19/02/2022.
//

import Foundation
import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        setBackgroundImage(color.imageRepresentation(), for: state)
    }
    
    func addBorders(borderColor: UIColor? = nil, radius: CGFloat = 0, borderWidth: CGFloat = 1) {
        let borderColor = borderColor ?? titleColor(for: .normal)
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth
        
        if radius > 0 {
            clipsToBounds = true
            layer.cornerRadius = radius
        }
    }
}
