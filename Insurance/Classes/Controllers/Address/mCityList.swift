//
//  Copyright © 2015年 NY. All rights reserved.
//

class mCityList: TableList {
    // MARK: - 🐤 继承 Taylor
    override func setTableViewStyle() -> UITableViewStyle {
        refreshControlMode = .None
        return .Grouped
    }
    
    override func getItemView<V : UITableView, T : Province, C : UITableViewCell>(listView: V, indexPath: NSIndexPath, item: T, cell: C) -> C {
        cell.textLabel?.text = item.name
        return cell
    }
    
    override func onPerform<T : Province>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            NSNotificationCenter.defaultCenter().postNotificationName("city", object: nil, userInfo: ["city" : data[indexPath.row]])
            navigationController?.popToRootViewControllerAnimated(true)
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
}
