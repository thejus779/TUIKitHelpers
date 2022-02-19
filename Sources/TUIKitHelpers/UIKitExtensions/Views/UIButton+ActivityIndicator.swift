//
//  UIButton+ActivityIndicator.swift
//  MAT
//
//  Created by Oleg Voitenko on 16/01/2020.
//  Copyright © 2020 User Adgents. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func showCustomLoader(style: UIActivityIndicatorView.Style = .gray) {
        showLoader(style: style)
        isUserInteractionEnabled = false
        setTitle(title(for: .normal), for: .reserved)
        setTitle("", for: .normal)
    }
    
    func hideCustomLoader() {
        hideLoader()
        isUserInteractionEnabled = true
        setTitle(title(for: .reserved), for: .normal)
    }
    
    var title: String? {
        get { title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }
    
    var font: UIFont? {
        get { titleLabel?.font }
        set { titleLabel?.font = newValue }
    }
}

