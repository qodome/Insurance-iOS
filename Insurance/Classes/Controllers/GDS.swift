//
//  Copyright © 2015年 NY. All rights reserved.
//

class GDS: TableDetail {
    var parameters: [CAPSPageMenuOption] = [
        .MenuHeight(NAVIGATION_BAR_HEIGHT),
        .MenuItemFont(UIFont(name: "HelveticaNeue-Light", size: DEFAULT_FONT_SIZE)!),
        .MenuItemWidth(90),
        .ScrollMenuBackgroundColor(UIColor.whiteColor()),
        .UnselectedMenuItemLabelColor(UIColor.darkGrayColor()),
        .SelectedMenuItemLabelColor(UIColor.colorWithHex(APP_COLOR)),
        .SelectionIndicatorColor(UIColor.colorWithHex(APP_COLOR)),
        .SelectionIndicatorHeight(2)
    ]
    var pageMenu: CAPSPageMenu! // 必须写在外面不能写在viewDidLoad
    var pageIndex = -1
    var objectId = "" // FIXME: 要求服务器端改成Number型, 并增加id_str
    //
    let controllers = [EnquiryCreate(), EnquiryWatting(), OfferList(), EnquiryWatting()]
    let titles = ["enquiry_create", "enquiry_waiting", "offer_list", "enquiry_waiting"]
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if checkLogin() {
            (loader as? HttpLoader)?.get(getEndpoint("check_enquiry"))
        }
    }
    
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("changeIndex:"), name: "changeIndex", object: nil)
    }
    
    override func onCreateLoader() -> BaseLoader? {
        return HttpLoader(endpoint: endpoint, mapping: smartMapping(CheckEnquiry.self))
    }
    
    override func onLoadSuccess<E : CheckEnquiry>(entity: E) {
        super.onLoadSuccess(entity)
        objectId = entity.status == 3 ? entity.orderId : entity.enquiryId
        moveTo(entity.status.integerValue)
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func changeIndex(notification: NSNotification) {
        let info = notification.object as! NSDictionary
        objectId = "\(info["id"]!)"
        moveTo(Int("\(info["index"]!)")!)
    }
    
    func moveTo(index: Int) {
        if pageIndex != index {
            pageIndex = index
            title = LocalizedString(titles[index])
            let controller = controllers[index]
            controller.endpoint = getEndpoint(["enquiries", "enquiries/\(objectId)", "enquiries/\(objectId)/offers", "orders/\(objectId)"][index])
            pageMenu = CAPSPageMenu(viewControllers: [controller], frame: CGRectMake(0, 0, view.frame.width, view.frame.height), pageMenuOptions: parameters)
            view.addSubview(pageMenu.view)
            addChildViewController(pageMenu) // 加了子页才能代码跳转导航
            pageMenu.controllerScrollView.scrollEnabled = false
        }
    }
}
