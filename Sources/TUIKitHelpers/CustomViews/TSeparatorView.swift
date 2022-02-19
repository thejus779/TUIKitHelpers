//
//  TSeparatorView.swift
//  
//
//  Created by Thejus Thejus on 29/12/2021.
//

import UIKit

public final class TSeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        if #available(iOS 13.0, *) {
            backgroundColor = .separator
        } else {
            backgroundColor = .lightGray
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: UIScreen.main.hairline)
    }
}
