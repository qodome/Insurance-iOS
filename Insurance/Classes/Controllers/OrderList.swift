//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class OrderList: TableList {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        title = LocalizedString("orders")
        refreshMode = .DidLoad
        (listView as! UITableView).registerClass(SubtitleCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func onCreateLoader() -> BaseLoader? {
        let mapping = smartListMapping(Order.self, children: ["user" : User.self, "product" : Product.self])
        return HttpLoader(endpoint: endpoint, mapping: mapping)
    }

    override func getItemView<V : UITableView, T : Order, C : UITableViewCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> UIView {
//        cell = listView.dequeueReusableCellWithIdentifier(cellId)
        cell.textLabel?.text = item.name as String
//        cell.imageView?.sd_setImageWithURL(NSURL(string: item.product!.imageUrl as String))
        cell.detailTextLabel?.text = "aaaaa"
        return cell
    }
}
