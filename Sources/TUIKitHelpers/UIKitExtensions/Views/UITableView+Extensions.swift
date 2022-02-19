//
//  UITableView+Extensions.swift
//
//
//  Created by Thejus Thejus on 19/02/2022.
//

import Foundation
import UIKit

extension UITableView {
    func resizeHeaderAndFooter() {
        if let tableHaederView = tableHeaderView {
            tableHaederView.frame.size.height = tableHaederView.systemLayoutSizeFitting(
                .init(width: bounds.width, height: .greatestFiniteMagnitude),
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            ).height
            self.tableHeaderView = tableHaederView
        }
        if let tableFooterView = tableFooterView {
            tableFooterView.frame.size.height = tableFooterView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            self.tableFooterView = tableFooterView
        }
    }
    func resizeHeaderView() {
        if let tableHeaderView = tableHeaderView {
            tableHeaderView.frame.size.height = tableHeaderView.systemLayoutSizeFitting(
                .init(width: bounds.width, height: bounds.height),
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            ).height
            self.tableHeaderView = tableHeaderView
        }
    }
    func setHeaderView(_ view: UIView) {
        self.tableHeaderView = view
        
        view.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width)
            make.top.equalTo(self.snp.top)
        }
        self.tableHeaderView?.layoutIfNeeded()
        self.tableHeaderView = view
    }

    func sizeFooterToFit() {
        guard let footer = self.tableFooterView else {
            return
        }
        
        footer.setNeedsLayout()
        footer.layoutIfNeeded()
        let height = footer.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
        var frame = footer.frame
        frame.size.height = height
        footer.frame = frame
        
        self.tableFooterView = footer
    }
    
    func sizeHeaderToFit() {
        guard let header = self.tableHeaderView else {
            return
        }
        
        header.setNeedsLayout()
        header.layoutIfNeeded()
        let height = header.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
        var frame = header.frame
        frame.size.height = height
        header.frame = frame
        
        self.tableHeaderView = header
    }
}
