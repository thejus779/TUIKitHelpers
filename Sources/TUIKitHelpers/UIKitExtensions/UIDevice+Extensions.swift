//
//  UIDevice+Extensions.swift
//  
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation
import WebKit

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    static var cfNetworkVersion: String {
        guard let bundle = Bundle(identifier: "com.apple.CFNetwork"),
            let versionAny = bundle.infoDictionary?[kCFBundleVersionKey as String],
            let version = versionAny as? String
        else { return "" }
        return "CFNetwork/\(version)"
    }
    
    var userAgent: String {
        return "\(UIApplication.shared.appName ?? "") \(UIApplication.shared.appVersion ?? "") \(constructedUserAgentString)"
    }
    private var constructedUserAgentString: String {
        let webView = WKWebView(frame: .zero)
        let deviceVersion = "\(UIDevice.current.systemVersion)".replacingOccurrences(of: ".", with: "_")
        let platform = UIDevice.current.systemName
        let deviceName = UIDevice.current.model
        let userAgentApplicationName = webView.configuration.applicationNameForUserAgent ?? ""
        return "\(deviceName) \(platform) \(deviceVersion) \(Self.cfNetworkVersion) \(userAgentApplicationName)"
    }
    
    // MARK: - Device detection
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_RETINA = UIScreen.main.scale >= 2.0
    
    static let SCREEN_WIDTH = Int(UIScreen.main.bounds.size.width)
    static let SCREEN_HEIGHT = Int(UIScreen.main.bounds.size.height)
    static let SCREEN_MAX_LENGTH = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
    static let SCREEN_MIN_LENGTH = Int( min(SCREEN_WIDTH, SCREEN_HEIGHT) )
    
    static let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH < 568
    static let IS_IPHONE_5 = IS_IPHONE && SCREEN_MAX_LENGTH == 568
    static let IS_IPHONE_5_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH < 568
    static let IS_IPHONE_6 = IS_IPHONE && SCREEN_MAX_LENGTH == 667
    static let IS_IPHONE_6P = IS_IPHONE && SCREEN_MAX_LENGTH == 736
    static let IS_IPHONE_X = IS_IPHONE && SCREEN_MAX_LENGTH == 812
}
