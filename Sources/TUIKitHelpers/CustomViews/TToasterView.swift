//
//  TToasterView.swift
//
//
//  Created by Thejus Thejus on 19/02/2022.
//

import UIKit
import SnapKit

class ToasterView: UIView {
    enum Style {
        case error
        case success
    }
    
    let container = UIView()
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = AppStyle.fonts.regular12
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var topContainerConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        container.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
        }
        
        addSubview(container)
        container.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            topContainerConstraint = make.top.equalToSuperview().constraint
        }
        container.backgroundColor = UIColor.clear
        
        style = .error
    }
    
    var style: Style = .error {
        didSet {
            switch style {
            case .error:
                backgroundColor = AppStyle.colors.amaranth
            case .success:
                backgroundColor = AppStyle.colors.java
            }
        }
    }
}
