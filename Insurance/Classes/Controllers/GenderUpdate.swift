//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class GenderUpdate: CheckListUpdate {
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [["m", "f"]]
    }
    
    override func getItemView<T : User, C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, data: T?, item: String, cell: C) -> UITableViewCell {
        cell.textLabel?.text = getString(GENDER_STRING, item)
        cell.accessoryType = item == data?.gender ? .Checkmark : .None
        return cell
    }
}
