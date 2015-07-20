//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class OrderDetail: TableDetail {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [
            [
                Item(title: "name"),
                Item(title: "total_fee"),
                Item(title: "status"),
            ],
            [
                Item(title: "created_time"),
                Item(title: "start_time"),
                Item(title: "end_time"),
                Item(title: "departure_time")
            ]
        ]
        refreshMode = .DidLoad
    }
    
    override func onCreateLoader() -> BaseLoader? {
        let mapping = smartMapping(Order.self)
        return HttpLoader(endpoint: endpoint, mapping: mapping)
    }
    
    override func onLoadSuccess<E : Order>(entity: E) {
        super.onLoadSuccess(entity)
    }
    
    override func getItemView<T : Order, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if indexPath.section == 0 {
            switch item.title {
            case "total_fee":
                let formatter = NSNumberFormatter()
                formatter.numberStyle = .CurrencyStyle
                cell.detailTextLabel?.text = formatter.stringFromNumber(NSNumber(double: data.totalFee.doubleValue / 100))
            default: break
            }
        }
        return cell
    }
    
    // MARK: 💜 UITableViewDataSource
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "" : "子订单 \(section)"
    }
}
