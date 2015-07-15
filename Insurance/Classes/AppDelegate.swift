//
//  Copyright (c) 2015年 NY. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: SocialAppDelegate {
    // MARK: - 🐤 Taylor
    override func onFinishLaunching(application: UIApplication, options: [NSObject : AnyObject]?) {
        super.onFinishLaunching(application, options: options)
        userToken = DEFAULT_TOKEN // 默认token
        RKObjectManager.sharedManager().HTTPClient.setDefaultHeader("Authorization", value: "JWT \(userToken)")
        //        NSUserDefaults.standardUserDefaults().registerDefaults(["userToken" : ""])
        //        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
