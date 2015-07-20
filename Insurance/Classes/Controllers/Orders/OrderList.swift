//
//  Copyright (c) 2015年 NY. All rights reserved.
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
        LOG(endpoint)
        let mapping = smartListMapping(Order.self)
        return HttpLoader(endpoint: endpoint, mapping: mapping)
    }
    
    override func getItemView<V : UITableView, T : Order, C : UITableViewCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> C {
//        cell.imageView?.sd_setImageWithURL(NSURL(string: item.product!.imageUrl as String))
//        cell = listView.dequeueReusableCellWithIdentifier(cellId)
        cell.textLabel?.text = item.name as String
//        cell.imageView?.sd_setImageWithURL(NSURL(string: item.product!.imageUrl as String))
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        cell.detailTextLabel?.text = formatter.stringFromNumber(NSNumber(double: item.totalFee.doubleValue / 100))
        return cell
    }
    
    override func onPerform<T : Order>(action: Action, item: T) {
        switch action {
        case .Open:
            startActivity(Item(title: "order_list", dest: OrderDetail.self))
        default:
            super.onPerform(action, item: item)
        }
    }
    
    override func onSegue(segue: UIStoryboardSegue, dest: UIViewController, id: String) {
        let item = getSelected().first as! Order
        dest.setValue(getEndpoint("orders/\(item.id)"), forKey: "endpoint")
    }
    
    // MARK: - 💜 UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        startActivity(Item(title: "order_list", dest: OrderDetail.self))
    }
}
