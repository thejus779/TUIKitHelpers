//
//  UIView+Loader.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation
import UIKit

protocol LoaderPresentable {
    func showLoader()
    func hideLoader()
}

extension UIView: LoaderPresentable {
    
    enum Background {
        case clear
        case white
        case custom(color: UIColor)
    }
    
    func showLoader() {
        showLoader(background: .clear)
    }
    
    func showLoader(style: UIActivityIndicatorView.Style) {
        showLoader(background: .clear, style: style)
    }
    
    @discardableResult
    func showLoader(background: Background, edges: UIEdgeInsets? = nil, style: UIActivityIndicatorView.Style = .gray) -> TLoadingView {
        if let loadingView = self.viewWithTag(TLoadingView.kLoadingViewTag) as? TLoadingView {
            // view already activity animating
            if !loadingView.spinner.isAnimating {
                loadingView.spinner.startAnimating()
            }
            return loadingView
        }
        let container = TLoadingView(style: style)
        
        switch background {
        case .clear:
            container.backgroundColor = UIColor.clear
        case .white:
            container.backgroundColor = UIColor.white
        case .custom(color: let color):
            container.backgroundColor = color
        }
        
        self.addSubview(container)
        container.snp.makeConstraints { (make) in
            if let edges = edges {
                make.edges.equalTo(edges)
            } else {
                make.top.equalTo(snp.topMargin)
                make.bottom.equalTo(snp.bottomMargin)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        }

        container.tag = TLoadingView.kLoadingViewTag
        container.spinner.startAnimating()
        
        return container
    }
    
    func hideLoader() {
        guard let view = self.viewWithTag(TLoadingView.kLoadingViewTag) else { return }
        view.removeFromSuperview()
    }
}
