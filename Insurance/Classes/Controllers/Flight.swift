//
//  Copyright © 2015年 NY. All rights reserved.
//

class Flight: GroupedTableDetail {
    var parameters: [CAPSPageMenuOption] = [
        .MenuHeight(NAVIGATION_BAR_HEIGHT),
        .MenuItemFont(UIFont(name: "HelveticaNeue-Light", size: DEFAULT_FONT_SIZE)!),
        .MenuItemWidth(90),
        .ScrollMenuBackgroundColor(.whiteColor()),
        .UnselectedMenuItemLabelColor(.darkGrayColor()),
        .SelectedMenuItemLabelColor(.colorWithHex(APP_COLOR)),
        .SelectionIndicatorColor(.colorWithHex(APP_COLOR)),
        .SelectionIndicatorHeight(2)
    ]
    var pageMenu: CAPSPageMenu! // 必须写在外面不能写在viewDidLoad
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
        navigationController?.toolbarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBarHidden = false
    }
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        endpoint = getEndpoint("popping/categories")
        mapping = getListMapping(Category.self)
        refreshMode = .DidLoad
    }
    
    override func onLoadSuccess<E : ListModel>(entity: E) {
        super.onLoadSuccess(entity)
        var controllerArray: [UIViewController] = []
        var tag = 0
        for item in entity.results as! [Category] {
            let controller: BaseCardList
            if tag == 0 {
                controller = CardList()
            } else {
                controller = storyboard?.instantiateViewControllerWithIdentifier("card_list") as! BaseCardList
            }
            controller.category = item
            controller.navController = navigationController
            controller.title = LocalizedString(item.name)
            controllerArray.append(controller)
            tag++
        }
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0, STATUS_BAR_HEIGHT, view.frame.width, view.frame.height), pageMenuOptions: parameters)
        view.addSubview(pageMenu.view)
    }
}
