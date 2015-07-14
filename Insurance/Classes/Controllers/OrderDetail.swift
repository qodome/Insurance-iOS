//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class OrderDetail: TableDetail {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [[
            Item(title: "created_time")
            ]]
        refreshMode = .DidLoad
    }
    
    override func onCreateLoader() -> BaseLoader? {
        let mapping = smartMapping(Order.self)
        return HttpLoader(endpoint: endpoint, mapping: mapping)
    }
    
    override func getItemView<T : Order, C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, data: T?, item: Item, cell: C) -> UITableViewCell {
        switch item.title {
        case "created_time":
            cell.textLabel?.text = item.title
        default: break
        }
        return cell
    }
}
