//
//  Copyright © 2015年 NY. All rights reserved.
//

class OrderDetail: GroupedTableDetail {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        mapping = getDetailMapping(Order.self)
        items = [
            [
                Item(title: "id"),
                Item(title: "name"),
                Item(title: "car_license_number"),
                Item(title: "total_fee"),
                Item(title: "created_time"),
                Item(title: "updated_time"),
                Item(title: "status")
            ]
        ]
        refreshMode = .DidLoad
    }
    
    override func onLoadSuccess<E : Order>(entity: E) {
        super.onLoadSuccess(entity)
    }
    
    override func getItemView<T : Order, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if indexPath.section == 0 {
            switch item.title {
            case "total_fee":
                cell.detailTextLabel?.text = getFormatterPrice(data.totalFee)
            case "status":
                cell.detailTextLabel?.text = getStatusString(data.status)
            default: break
            }
        }
        return cell
    }
    
    // MARK: - 💜 UITableViewDataSource
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "" : "子订单 \(section)"
    }
}
