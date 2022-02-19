//
//  TUnderlineButton.swift
//
//
//  Created by Thejus Thejus on 19/02/2022.
//

import UIKit

class UnderlineButton: UIButton {
    var text: String? {
        didSet {
            configure()
        }
    }
    
    var color: UIColor? {
        didSet {
            configure()
        }
    }
    
    var fontText: UIFont? {
        didSet {
            configure()
        }
    }
    
    private func configure() {
        guard let text = self.text else { return }
        var attributes = [NSAttributedString.Key: Any]()
        if let color = self.color {
            attributes[NSAttributedString.Key.foregroundColor] = color
        }
        if let font = self.fontText {
            attributes[NSAttributedString.Key.font] = font
        }
        attributes[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
        let attributed = NSAttributedString(string: text, attributes: attributes)
        self.setAttributedTitle(attributed, for: .normal)
    }
}
