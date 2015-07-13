//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class GenderUpdate: CheckListUpdate {
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [[Item(title: "m"), Item(title: "f")]]
    }
    
    override func getItemView<T : User, C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, data: T?, item: Item, cell: C) -> UITableViewCell {
        let c = super.getItemView(tableView, indexPath: indexPath, data: data, item: item, cell: cell)
        c.textLabel?.text = getString(GENDER_STRING, item.title)
        c.accessoryType = item.title == data?.gender ? .Checkmark : .None
        return c
    }
}
