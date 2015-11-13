//
//  Copyright © 2015年 NY. All rights reserved.
//

class OrderList: TableList {
    var allData: [ModelObject] = []
    var insuranceData : [ModelObject] = []
    var selectedIndex: Int = 0
    
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
        let segmentController = HMSegmentedControl(sectionTitles: [LocalizedString("all"), LocalizedString("auto_insurance")])
        // segmentController.borderType = .Bottom
        segmentController.selectionIndicatorColor = .colorWithHex(APP_COLOR)
        segmentController.selectionIndicatorHeight = 2
        segmentController.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
        segmentController.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe
        segmentController.selectedTitleTextAttributes = [NSForegroundColorAttributeName : UIColor.colorWithHex(APP_COLOR)]
        segmentController.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkTextColor(), NSFontAttributeName: UIFont.systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)]
        segmentController.indexChangeBlock = { index in
            self.selectedIndex = index
            self.data = index == 0 ? self.allData : self.insuranceData
            listView.reloadData()
        }
        segmentController.frame = CGRectMake(0, STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT, view.frame.width, 36)
        view.addSubview(segmentController)
    }
    
    override func onLoadSuccess<E : ListModel>(entity: E) {
        super.onLoadSuccess(entity)
        allData = data
        insuranceData.removeAll()
        for orderData in data {
            if (orderData as! Order).productId == 1 {
                insuranceData.append(orderData)
            }
        }
        data = selectedIndex == 0 ? allData : insuranceData
        (listView as! UITableView).reloadData()
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
