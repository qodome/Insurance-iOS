//
//  Copyright © 2015年 NY. All rights reserved.
//

class Main: UITabBarController {
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.colorWithHex(APP_COLOR)
        let items = ["home", /** "discover", */ "compare", "flight", "me"]
        for i in 0..<items.count {
            tabBar.items?[i].title = items[i]
        }
        selectedIndex = 3
    }
    
    // MARK: - 💜 场景切换 (Segue)
    override func viewControllerForUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject?) -> UIViewController? {
        // 8.1以下手动修复 http://stackoverflow.com/questions/25654941/unwind-segue-not-working-in-ios-8
        return selectedViewController?.viewControllerForUnwindSegueAction(action, fromViewController: fromViewController, withSender: sender)
    }
}
