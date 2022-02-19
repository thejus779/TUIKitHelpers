//
//  TLoaderEmbeddedBarButton.swift
//  
//
//  Created by Thejus Thejus on 29/12/2021.
//
import UIKit

/**
 A `UIBarButtonItem` that has an activity indicator .
 
 The loader inherits the tint color.
 */

public final class TLoaderEmbeddedBarButton: UIBarButtonItem {
    /**
     Create a new `UIBarButtonItem`
     
     - Parameter color: the tint color for the spinner (default: `.gray`)
     */
    public init(color: UIColor = .gray) {
        super.init()
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let activityIndicatorView: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            activityIndicatorView = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicatorView = UIActivityIndicatorView(style: .gray)
        }
        activityIndicatorView.color = tintColor ?? .gray
        customView = activityIndicatorView
        startAnimating()
    }
    /// Animate the spinner
    public func startAnimating() {
        (customView as? UIActivityIndicatorView)?.startAnimating()
    }
    
    /// Stop animating the spinner
    public func stopAnimating() {
        (customView as? UIActivityIndicatorView)?.stopAnimating()
    }
    
    public override var tintColor: UIColor? {
        didSet {
            (customView as? UIActivityIndicatorView)?.color = tintColor
        }
    }
}
