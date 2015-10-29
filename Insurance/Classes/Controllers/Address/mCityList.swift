//
//  Copyright © 2015年 NY. All rights reserved.
//

class mCityList: TableDetail {
    var cities: [Province] = []
    var provinceName = ""
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        title = provinceName
        items = [[]]
        for city in cities {
            items[0] += [Item(title: city.name, segue: "back")]
        }
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
//        cell.accessoryType = .None
        return cell
    }
    
    // MARK: - 💜 UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSNotificationCenter.defaultCenter().postNotificationName("city", object: nil, userInfo: ["city" : cities[indexPath.row]])
        navigationController?.popToRootViewControllerAnimated(true)
    }
}
