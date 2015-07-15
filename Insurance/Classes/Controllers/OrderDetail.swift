//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class OrderDetail: TableDetail {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [[
            Item(title: "price"),
            Item(title: "created_time")
            ]]
        refreshMode = .DidLoad
    }
    
    override func onCreateLoader() -> BaseLoader? {
        let mapping = smartMapping(Order.self)
        return HttpLoader(endpoint: endpoint, mapping: mapping)
    }
    
    override func getItemView<T : Order, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        switch item.title {
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
}
