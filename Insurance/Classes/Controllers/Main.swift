//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class Main: UITabBarController {
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.colorWithHex(APP_COLOR)
        UIView.setAnimationsEnabled(true) // 从登陆跳转后恢复动画
        (tabBar.items?.first as! UITabBarItem).title = LocalizedString("home")
        (tabBar.items![1] as! UITabBarItem).title = LocalizedString("discover")
        (tabBar.items![2] as! UITabBarItem).title = LocalizedString("compare")
        (tabBar.items?.last as! UITabBarItem).title = LocalizedString("me")
        selectedIndex = 4
    }
    
    // MARK: - 💜 场景切换 (Segue)
    override func viewControllerForUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject?) -> UIViewController? {
        // 8.1以下手动修复http://stackoverflow.com/questions/25654941/unwind-segue-not-working-in-ios-8
        return selectedViewController?.viewControllerForUnwindSegueAction(action, fromViewController: fromViewController, withSender: sender)
    }
}
