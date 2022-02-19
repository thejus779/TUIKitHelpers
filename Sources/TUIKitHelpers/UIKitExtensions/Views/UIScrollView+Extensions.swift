//
//  UIScrollView+Extensions.swift
//
//
//  Created by Thejus Thejus on 19/02/2022.
//

import Foundation
import UIKit

extension UIScrollView {
    func screenshot() -> UIImage? {
        let savedContentOffset = contentOffset
        let savedFrame = frame
        
        UIGraphicsBeginImageContextWithOptions(contentSize, true, UIScreen.main.scale)
        contentOffset = .zero
        frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        contentOffset = savedContentOffset
        frame = savedFrame
        
        return image
    }
    
    func reachedBottom() -> Bool {
        return self.reachedBottom(with: 0.0)
    }
    
    func reachedBottom(with offset: CGFloat) -> Bool {
        let bottomEdge = self.contentOffset.y + self.frame.size.height
        return bottomEdge >= self.contentSize.height - offset
    }
}
