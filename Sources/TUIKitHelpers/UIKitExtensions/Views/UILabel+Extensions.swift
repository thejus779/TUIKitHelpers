//
//  UILabel+Extensions.swift
//
//
//  Created by Thejus Thejus on 19/02/2022.
//

import Foundation
import UIKit

extension UILabel {
    var numberOfVisibleLines: Int {
        let textSize = CGSize(width: CGFloat(self.frame.size.width - self.frame.origin.x), height: CGFloat(MAXFLOAT))
        let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize: Int = lroundf(Float(self.font.pointSize))
        return rHeight / charSize
    }
    var isTruncated: Bool {
        if let attributedText = attributedText, !attributedText.string.isEmpty {
            let truncated = isTruncated(
                text: attributedText.string,
                attributes: attributedText.attributes(at: 0, effectiveRange: nil)
            )
            return truncated
        } else if let text = text, !text.isEmpty, let font = font {
            return isTruncated(text: text, attributes: [.font: font])
        } else {
            return false
        }
    }
    
    private func isTruncated(text: String, attributes: [NSAttributedString.Key: Any]) -> Bool {
        let labelTextSize = (text as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        ).size
        return labelTextSize.height > bounds.size.height
    }
 
    func textDropShadow(shadowRadius: CGFloat, width: CGFloat, height: CGFloat, opacity: Float, color: UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: width, height: height)
    }
}
