//
//  UIWindow+Extensions.swift
//  
//
//  Created by Thejus Thejus on 19/02/2022.
//

import Foundation
import UIKit

public extension UIWindow {
    /// Lookup the key window of the current app
    /// - Returns: The key window
    static func keyWindow() -> UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
