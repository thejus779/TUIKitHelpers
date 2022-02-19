//
//  TLoadingView.swift
//
//
//  Created by Thejus Thejus on 19/02/2022.
//

import Foundation
import UIKit

class TLoadingView: UIView {
    
    static let kLoadingViewTag = 8751262
    
    let spinner: UIActivityIndicatorView
    
    // MARK: - Initializers
    init(style: UIActivityIndicatorView.Style) {
        self.spinner = UIActivityIndicatorView(style: style)
        super.init(frame: CGRect.zero)
        setup()
    }
    
    override init(frame: CGRect) {
        self.spinner = UIActivityIndicatorView(style: .gray)
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.spinner = UIActivityIndicatorView(style: .gray)
        super.init(coder: coder)
        setup()
    }
    
    init() {
        self.spinner = UIActivityIndicatorView(style: .gray)
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        addSubview(spinner)
        spinner.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
        }
    }
}
