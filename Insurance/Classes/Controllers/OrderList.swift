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
        let mapping = smartListMapping(Order.self, children: ["user" : User.self, "product" : Product.self])
        return HttpLoader(endpoint: endpoint, mapping: mapping)
    }

    override func getItemView<V : UITableView, T : Order, C : UITableViewCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> UIView {
//        cell = listView.dequeueReusableCellWithIdentifier(cellId)
        cell.textLabel?.text = item.name as String
//        cell.imageView?.sd_setImageWithURL(NSURL(string: item.product!.imageUrl as String))
        cell.detailTextLabel?.text = data?.valueForKey(item.name as String) as? String
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        startActivity(Item(title: "order_list", dest: OrderDetail.self))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let dest = segue.destinationViewController as? UIViewController
        let item = getSelected().first as! Order
        
        LOG(getEndpoint("orders/\(item.id)"))
        dest?.setValue(getEndpoint("orders/\(item.id)"), forKey: "endpoint")
    }
}
