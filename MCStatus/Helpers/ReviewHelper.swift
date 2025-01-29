import StoreKit
import SwiftUI

class ReviewHelper {
    
    // UserDefaults keys
    private enum UserDefaultKey: String {
        case launchCount,
             lastRequestTimestamp,
             lastVersion
    }
    
    @AppStorage(UserDefaultKey.launchCount.rawValue) private var launchCount = 0
    @AppStorage(UserDefaultKey.lastRequestTimestamp.rawValue) private var lastRequestTimestamp = 0.0
    @AppStorage(UserDefaultKey.lastVersion.rawValue) private var lastVersion = ""
    
    private let currentVersion: String
    private let launchCountLimit = 5
    
    init() {
        // Get the current app version from the Info.plist
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.currentVersion = version
        } else {
            self.currentVersion = "1.0" // Fallback version
        }
    }
    
    // Call this method when the app launches
    func appLaunched() {
        launchCount += 1
    }
    
    // Check if the review prompt should be shown
    func shouldShowRequestView() -> Bool {
        let isLaunchCountSufficient = launchCount >= launchCountLimit
        let isTimeElapsed = isTimeSinceLastRequestExceeded()
        let isNewVersion = lastVersion != currentVersion
        
        return isLaunchCountSufficient && isTimeElapsed && isNewVersion
    }
    
    // Call this method when the review prompt has been shown
    func didShowReview() {
        lastRequestTimestamp = Date().timeIntervalSince1970 // Store current time as Unix timestamp
        lastVersion = currentVersion
    }
    
    
    // Check if six months have passed since the last request
    private func isTimeSinceLastRequestExceeded() -> Bool {
        
        
        // Calculate the timestamp for six months ago
        let sixMonthsInSeconds: TimeInterval = 6 * 30 * 24 * 60 * 60 // Approximation of 6 months
        let sixMonthsAgo = Date().timeIntervalSince1970 - sixMonthsInSeconds
        
        //if the value is 0, user just installed, set it to 6 months ago, plus 1 day, so user wont see alert for 2 days after install
        if self.lastRequestTimestamp == 0 {
            self.lastRequestTimestamp = sixMonthsAgo + 48 * 60 * 60
        }
        
        return lastRequestTimestamp < sixMonthsAgo
    }
}
