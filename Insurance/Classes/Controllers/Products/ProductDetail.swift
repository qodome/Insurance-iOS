//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class ProductDetail: TableDetail {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        refreshMode = .DidLoad
        items = [
            [Item(title: "name")],
            [
                Item(title: "price"),
                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
//                Item(title: "price"),
                Item(title: "created_time")
            ]]
        let button = QuickButton(frame: CGRectMake(0, view.frame.height - 44, view.frame.width, 44))
        button.addTarget(self, action: "buy:", forControlEvents: .TouchUpInside)
        button.setTitle(LocalizedString("buy"), forState: .Normal)
        view.addSubview(button)
    }
    
    override func onCreateLoader() -> BaseLoader? {
        let mapping = smartMapping(Product.self)
        return HttpLoader(endpoint: endpoint, mapping: mapping)
    }
    
    override func getItemView<T : Product, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        switch item.title {
        case "name":
            cell.detailTextLabel?.text = data.name as String
        case "price":
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            cell.detailTextLabel?.text = formatter.stringFromNumber(NSNumber(double: data.price.doubleValue / 100))
        case "created_time":
            cell.detailTextLabel?.text = TTTTimeIntervalFormatter().stringForTimeInterval(data.valueForKey(item.title.camelCaseString())!.timeIntervalSinceNow)
        default: break
        }
        return cell
    }
    
    func buy(sender: AnyObject) {
        performSegueWithIdentifier("segue.product_detail-order_create", sender: self)
    }
    
    // MARK: - 💜 场景切换 (Segue)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let dest = segue.destinationViewController as! UIViewController
        let product = data as! Product
        let order = Order()
        order.name = product.name
        order.totalFee = product.price
        order.product = product
        dest.setValue(order, forKey: "data")
    }
}
