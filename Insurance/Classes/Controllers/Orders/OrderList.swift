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
        mapping = smartListMapping(Order.self, children: ["user" : User.self, "product" : Product.self])
        refreshMode = .DidLoad
        listView.registerClass(OrderCell.self, forCellReuseIdentifier: cellId)
        let segmentController = HMSegmentedControl(sectionTitles: ["车险", "划痕险", "航延乐"])
        segmentController.selectionIndicatorHeight = 2
        segmentController.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blackColor(), NSFontAttributeName: UIFont.systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)]
        segmentController.indexChangeBlock = { index in
            LOG(index)
        }
        segmentController.selectedTitleTextAttributes = [NSForegroundColorAttributeName : UIColor.colorWithHex(APP_COLOR)]
        segmentController.selectionIndicatorColor = .colorWithHex(APP_COLOR)
        segmentController.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe
        segmentController.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
        segmentController.frame = CGRectMake(0, 0, view.frame.width, 35)
        listView.addSubview(segmentController)
    }
    
    override func getItemView<V : UITableView, T : Order, C : OrderCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> C {
        cell.setData(item)
        cell.accessoryType = .DisclosureIndicator
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
        return 75 + PADDING
    }
}
