//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class Main: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.setAnimationsEnabled(true) // 从登陆跳转后恢复动画
        (tabBar.items?.first as! UITabBarItem).title = LocalizedString("home")
        (tabBar.items![1] as! UITabBarItem).title = LocalizedString("discover")
        (tabBar.items![2] as! UITabBarItem).title = LocalizedString("compare")
        (tabBar.items?.last as! UITabBarItem).title = LocalizedString("me")
        selectedIndex = 2
    }
}
