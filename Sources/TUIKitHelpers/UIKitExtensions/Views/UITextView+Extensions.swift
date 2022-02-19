//
//  File.swift
//  
//
//  Created by Thejus Thejus on 19/02/2022.
//

import Foundation
import UIKit

extension UITextView {
    func setAttributedPrefixedLink(prefix: String, prefixFont: UIFont, link: String, linkFont: UIFont, url: URL, textColor: UIColor, delegate: UITextViewDelegate) {
        attributedText = .concatenating(
            .attributedString(
                text: prefix,
                font: prefixFont,
                color: textColor,
                lineHeight: prefixFont.pointSize * 1.5,
                alignment: .left
            ),
            .init(
                string: link,
                attributes: [.link: url, .font: linkFont]
            )
        )
        enableUrlDetection(
            linkFont: linkFont,
            linkColor: textColor
        )
        self.delegate = delegate
    }
    func enableUrlDetection(linkFont: UIFont, linkColor: UIColor) {
        isEditable = false
        isUserInteractionEnabled = true
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        linkTextAttributes = [
            .font: linkFont,
            .foregroundColor: linkColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
}
