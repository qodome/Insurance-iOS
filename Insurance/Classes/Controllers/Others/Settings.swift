//
//  Copyright (c) 2014年 NY. All rights reserved.
//

class Settings: TableDetail {
    var counter = 0
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [
            [Item(title: "about", dest: About.self)],
            [Item(title: "developer")],
            [Item(title: "sign_out", color: UIColor.destructiveColor())]
        ]
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if item.title == "developer" && TestEnv {
            cell.textLabel?.textColor = UIColor.defaultColor()
        }
        return cell
    }
    
    // MARK: - 💜 UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = getItem(indexPath)
        switch item.title {
        case "developer":
            if counter < 5 {
                counter++
            } else {
                counter = 0
                TestEnv = !TestEnv
                reloadSettings()
                tableView.reloadData()
            }
        case "sign_out":
            tableView.deselectRowAtIndexPath(indexPath, animated: true) // 取消选中
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            alert.addAction(UIAlertAction(title: LocalizedString("sign_out"), style: .Destructive) { (action) in
                NSUserDefaults.standardUserDefaults().removeObjectForKey(TaylorR.Pref.UserToken.rawValue) // 删除token
                userToken = DEFAULT_TOKEN
                RKObjectManager.sharedManager().HTTPClient.setDefaultHeader("Authorization", value: "JWT \(userToken)")
                showAlert(self, title: "已注销")
                })
            showActionSheet(self, alert: alert)
        default:
            super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        }
    }
}
