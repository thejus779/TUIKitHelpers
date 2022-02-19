//
//  UIApplication+Extensions
//  
//
//  Created by Thejus Thejus on 29/12/2021.
//

import UIKit

extension UIApplication {
    var appDisplayName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    var appName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    var buildNumber: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    var currentCommit: String? {
        return Bundle.main.object(forInfoDictionaryKey: "GIT_COMMIT_HASH" as String) as? String
    }
    var modelIdentifier: String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(
            bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)),
            encoding: .ascii
            )?.trimmingCharacters(in: .controlCharacters) ?? ""
    }
    var osVersion: String {
        return UIDevice.current.systemVersion
    }
    var deviceidentifier: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    var bundleId: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
}

extension UIApplication {
    func clearLaunchScreenCache() {
        do {
            try FileManager.default.removeItem(atPath: NSHomeDirectory() + "/Library/SplashBoard")
        } catch {
            print("Failed to delete launch screen cache: \(error)")
        }
    }

}
