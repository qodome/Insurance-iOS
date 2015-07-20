//
//  Copyright (c) 2014年 NY. All rights reserved.
//

class Me: UserDetail {
    
    func checkLogin() {
        if userToken == DEFAULT_TOKEN { // 未登录
            let dest = storyboard?.instantiateViewControllerWithIdentifier("sign_in") as! UIViewController
            presentViewController(UINavigationController(rootViewController: dest), animated: true, completion: nil) // present跳转增加导航栏
        }
    }
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewDidLoad() {
        super.viewDidLoad()
//        checkLogin()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        checkLogin()
        endpoint = getEndpoint("users/\(userId)")
        loader?.endpoint = endpoint
    }
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        let iconInsurances = FAKIonIcons.iosMedicalIconWithSize(CGSizeSettingsIcon.width)
        iconInsurances.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_GREEN))
        let iconOrders = FAKIonIcons.iosPaperIconWithSize(CGSizeSettingsIcon.width)
        iconOrders.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_YELLOW))
        let iconSettings = FAKIonIcons.iosGearIconWithSize(CGSizeSettingsIcon.width)
        iconSettings.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_BLUE))
        items += [
            [
                Item(icon: FAKIonIcons.androidCarIconWithSize(CGSizeSettingsIcon.width).imageWithSize(CGSizeSettingsIcon), title: "vehicles", dest: VehicleList.self),
                Item(icon: iconInsurances.imageWithSize(CGSizeSettingsIcon), title: "insurances", dest: nil),
                Item(icon: iconOrders.imageWithSize(CGSizeSettingsIcon), title: "orders", dest: OrderList.self)
            ],
            [
                Item(icon: iconSettings.imageWithSize(CGSizeSettingsIcon), title: "settings", dest: Settings.self)
            ]
        ]
    }
    
    override func onLoadSuccess<E : User>(entity: E) {
        super.onLoadSuccess(entity)
        title = LocalizedString("me")
    }
    
    // MARK: - 💜 场景切换 (Segue)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let dest = segue.destinationViewController as! UIViewController
        switch segue.identifier!.componentsSeparatedByString("-")[1] {
        case "profile":
            dest.setValue(data, forKey: "data")
        case "vehicle_list":
            dest.setValue("\(endpoint)vehicles/", forKey: "endpoint")
        case "order_list":
            dest.setValue("\(endpoint)orders/", forKey: "endpoint")
        default: break
        }
    }
}
