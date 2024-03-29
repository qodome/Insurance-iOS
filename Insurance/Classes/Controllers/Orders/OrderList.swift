//
//  Copyright © 2015年 NY. All rights reserved.
//

class OrderList: TableList {
    // MARK: - 🐤 Taylor
    override func setTableViewStyle() -> UITableViewStyle {
        return .Grouped
    }
    
    override func onPrepare<T : UITableView>(listView: T) {
        super.onPrepare(listView)
        title = LocalizedString("orders")
        mapping = getListMapping(Order.self, children: [RKChild(path: "user", type: User.self), RKChild(path: "product", type: Product.self)])
        refreshMode = .DidLoad
        listView.registerClass(OrderCell.self, forCellReuseIdentifier: cellId)
        let segmentController = HMSegmentedControl(sectionTitles: [LocalizedString("all"), LocalizedString("auto_insurance")])
        segmentController.selectionIndicatorColor = .colorWithHex(APP_COLOR)
        segmentController.selectionIndicatorHeight = 2
        segmentController.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
        segmentController.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe
        segmentController.selectedTitleTextAttributes = [NSForegroundColorAttributeName : UIColor.colorWithHex(APP_COLOR)]
        segmentController.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkTextColor(), NSFontAttributeName: UIFont.systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)]
        segmentController.indexChangeBlock = { index in
            index == 0 ? self.loader?.read() : self.loader?.read(self.endpoint, parameters: ["product_id" : "1"])
        }
        segmentController.frame = CGRectMake(0, STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT, view.frame.width, 36)
        view.addSubview(segmentController)
    }
    
    override func getItemView<V : UITableView, T : Order, C : OrderCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> C {
        cell.setData(item)
        return cell
    }
    
    override func onPerform<T : Order>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            startActivity(Item(title: "order_detail", dest: OrderDetail.self))
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
    
    override func onSegue(segue: UIStoryboardSegue?, dest: UIViewController, id: String) {
        let item = getSelected().first as! Order
        dest.setValue(getEndpoint("orders/\(item.id)"), forKey: "endpoint")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
}
