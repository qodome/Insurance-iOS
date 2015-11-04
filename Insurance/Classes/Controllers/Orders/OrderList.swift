//
//  Copyright © 2015年 NY. All rights reserved.
//

class OrderList: TableList {
    // MARK: - 🐤 Taylor
    override func onPrepare<T : UITableView>(listView: T) {
        super.onPrepare(listView)
        title = LocalizedString("orders")
        refreshMode = .DidLoad
        listView.registerClass(SubtitleCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func onCreateLoader() -> BaseLoader? {
        let mapping = smartListMapping(Order.self, children: ["user" : User.self, "product" : Product.self])
        return HttpLoader(endpoint: endpoint, mapping: mapping)
    }
    
    override func getItemView<V : UITableView, T : Order, C : UITableViewCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> C {
        //        cell = listView.dequeueReusableCellWithIdentifier(cellId)
        cell.textLabel?.text = item.name
        //        cell.imageView?.sd_setImageWithURL(NSURL(string: item.product!.imageUrl))
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        cell.detailTextLabel?.text = formatter.stringFromNumber(NSNumber(double: item.totalFee.doubleValue / 100))
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
}
