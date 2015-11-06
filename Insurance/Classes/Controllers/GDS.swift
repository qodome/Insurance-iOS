//
//  Copyright © 2015年 NY. All rights reserved.
//

class GDS: GroupedTableDetail, EAIntroDelegate {
    var parameters: [CAPSPageMenuOption] = [
        .MenuHeight(NAVIGATION_BAR_HEIGHT + STATUS_BAR_HEIGHT),
        //        .MenuItemFont(UIFont(name: "HelveticaNeue-Light", size: DEFAULT_FONT_SIZE)!),
        //        .MenuItemWidth(90),
        .ScrollMenuBackgroundColor(.whiteColor()),
        //        .UnselectedMenuItemLabelColor(.darkGrayColor()),
        //        .SelectedMenuItemLabelColor(.colorWithHex(APP_COLOR)),
        //        .SelectionIndicatorColor(.colorWithHex(APP_COLOR)),
        //        .SelectionIndicatorHeight(2)
    ]
    var pageMenu: CAPSPageMenu! // 必须写在外面不能写在viewDidLoad
    var pageIndex = -1
    var objectId = 0 // FIXME: 要求服务器端改成Number型, 并增加id_str
    //
    let controllers: [BaseController.Type] = [EnquiryCreate.self, EnquiryWaiting.self, OfferList.self, EnquiryWaiting.self]
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if checkLogin() {
            loader?.read(getEndpoint("check_enquiry"))
        }
    }
    
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        mapping = smartMapping(CheckEnquiry.self)
        // 引导页
        var pages: [EAIntroPage] = []
        let pageConfigs = [
            [0xFFFFFF, "ic_intro_1", "买车险 找小马", 0],
            [0xFFFFFF, "ic_intro_2", "最便宜的车险", 0],
        ]
        let width = view.frame.width / 8 * 5
        for config in pageConfigs {
            let page = EAIntroPage()
            page.bgColor = UIColor.colorWithHex(config[0] as! Int)
            page.titleIconView = UIImageView(image: UIImage(named: config[1] as! String))
            page.titleIconView.frame.size = CGSizeMake(width, width)
            page.titleIconPositionY = (view.frame.height - width) / 2
            page.title = LocalizedString(config[2] as! String)
            page.titleFont = UIFont.systemFontOfSize(20)
            page.titleColor = UIColor.colorWithHex(config[3] as! Int)
            pages.append(page)
        }
        let intro = EAIntroView(frame: view.frame, andPages: pages)
        intro.skipButton.hidden = true
        intro.delegate = self
        if NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion")!.integerValue > getInteger("version") {
            intro.showFullscreenWithAnimateDuration(0)
        }
        pageMenu = CAPSPageMenu(viewControllers: [], frame: view.frame, options: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("changeIndex:"), name: "changeIndex", object: nil)
    }
    
    override func onLoadSuccess<E : CheckEnquiry>(entity: E) {
        super.onLoadSuccess(entity)
        objectId = entity.status == 3 ? entity.orderId.integerValue : entity.enquiryId.integerValue
        moveTo(entity.status.integerValue)
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func changeIndex(notification: NSNotification) {
        let info = notification.object as! NSDictionary
        objectId = Int(info["id"] as! String)!
        moveTo(Int("\(info["index"]!)")!)
    }
    
    func moveTo(index: Int) {
        if pageIndex != index {
            if !pageMenu.controllerArray.isEmpty {
                pageMenu.removePageAtIndex(0)
            }
            pageIndex = index
            let controller = controllers[index].init()
            controller.endpoint = getEndpoint(["enquiries", "enquiries/\(objectId)", "enquiries/\(objectId)/offers", "orders/\(objectId)"][index])
            pageMenu = CAPSPageMenu(viewControllers: [controller], frame: view.frame, pageMenuOptions: parameters)
            pageMenu.controllerScrollView.scrollEnabled = false
            view.addSubview(pageMenu.view)
            addChildViewController(pageMenu) // 加了子页才能代码跳转导航
        }
    }
    
    // MARK: - 💙 EAIntroDelegate
    func introDidFinish(introView: EAIntroView!) {
        putInteger("version", value: NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion")!.integerValue)
        setNeedsStatusBarAppearanceUpdate()
    }
}
