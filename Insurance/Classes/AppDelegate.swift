//
//  Copyright © 2015年 NY. All rights reserved.
//

@UIApplicationMain
class AppDelegate: SocialAppDelegate {
    // MARK: - 🐤 Taylor
    override func onFinishLaunching(application: UIApplication, options: [NSObject : AnyObject]?) {
        super.onFinishLaunching(application, options: options)
        userId = getInteger(TaylorR.Pref.UserId.rawValue)
        userToken = getString(TaylorR.Pref.UserToken.rawValue, defaultValue: DEFAULT_TOKEN) // 默认token
        RKObjectManager.sharedManager().HTTPClient.setDefaultHeader("Authorization", value: "JWT \(userToken)")
        //        NSUserDefaults.standardUserDefaults().registerDefaults(["userToken" : ""])
        //        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}
