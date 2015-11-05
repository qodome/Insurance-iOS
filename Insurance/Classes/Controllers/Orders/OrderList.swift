//
//  Copyright © 2015年 NY. All rights reserved.
//

class OrderList: TableList {
    // MARK: - 🐤 Taylor
    override func onPrepare<T : UITableView>(listView: T) {
        super.onPrepare(listView)
        title = LocalizedString("orders")
        refreshMode = .DidLoad
        listView.registerClass(OrderCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func onCreateLoader() -> BaseLoader? {
        let mapping = smartListMapping(Order.self, children: ["user" : User.self, "product" : Product.self])
        return HttpLoader(endpoint: endpoint, mapping: mapping)
    }
    
    override func getItemView<V : UITableView, T : Order, C : OrderCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> C {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
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
    
    override func onSegue(segue: UIStoryboardSegue, dest: UIViewController, id: String) {
        let item = getSelected().first as! Order
        dest.setValue(getEndpoint("orders/\(item.id)"), forKey: "endpoint")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75 + PADDING
    }
}
