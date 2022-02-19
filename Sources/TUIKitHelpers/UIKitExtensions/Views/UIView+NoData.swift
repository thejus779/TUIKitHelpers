//
//  UIView+NoData.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation
import UIKit

extension UIView {
    
    private static let emptyViewTag = 14326124
    
    var hasErrorView: Bool {
        let existingView = self.viewWithTag(UIView.emptyViewTag) as? MATNoDataView
        return existingView != nil
    }
    
    @discardableResult
    func showNoDataView(title: String?,
                        message: String?,
                        image: UIImage,
                        textSize: MATNoDataView.TextSize? = nil,
                        colorStyle: MATNoDataView.ColorStyle? = nil,
                        edges: UIEdgeInsets? = nil) -> MATNoDataView {
        var view = MATNoDataView.fromNib() as MATNoDataView
        if let existingView = self.viewWithTag(UIView.emptyViewTag) as? MATNoDataView {
            view = existingView
        } else {
            self.addSubview(view)
            view.snp.makeConstraints { (make) in
                if let edges = edges {
                    make.edges.equalTo(edges)
                } else {
                    make.top.equalTo(snp.topMargin)
                    make.bottom.equalTo(snp.bottomMargin)
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                }
            }
        }

        view.tag = UIView.emptyViewTag
        view.labelTitle.text = title
        view.labelTitle.isHidden = title == nil
        view.labelMessage.text = message
        view.labelMessage.isHidden = message == nil
        view.imageView.image = image
        if let size = textSize {
            view.textSize = size
        }
        if let style = colorStyle {
            view.colorStyle = style
        }
        return view
    }
    
    func hideNoDataView() {
        guard let view = self.viewWithTag(UIView.emptyViewTag) else { return }
        view.removeFromSuperview()
    }
    
    enum ErrorPresentationMode {
        case inView
        case toaster
    }
    
    @discardableResult
    func showError(_ error: Error,
                   mode: ErrorPresentationMode,
                   edges: UIEdgeInsets? = nil,
                   colorStyle: MATNoDataView.ColorStyle? = nil,
                   image: UIImage? = nil,
                   completion: VoidBlock? = nil) -> UIView? {
        switch mode {
        case .inView:
            return showNoDataView(title: L10n.errorTitleGeneral,
                                  message: error.localizedDescription,
                                  image: image ?? Asset.Assets.imageNoDataSmileViolet.image,
                                  colorStyle: colorStyle,
                                  edges: edges)
        case .toaster:
            showToaster(message: error.localizedDescription, completion: completion)
            return nil
        }
    }
}
