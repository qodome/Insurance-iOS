//
//  Copyright © 2015年 NY. All rights reserved.
//

class Settings: GroupedTableDetail {
    var counter = 0
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [
            [Item(title: "about", dest: About.self)],
            [Item(title: "developer", selectable: true)],
            [Item(title: "sign_out", color: .destructiveColor(), selectable: true)]
        ]
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if item.title == "developer" && TestEnv {
            cell.textLabel?.textColor = .defaultColor()
        }
        return cell
    }
    
    override func onPerform<T : Item>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            switch item.title {
            case "developer":
                if counter < 5 {
                    counter++
                } else {
                    counter = 0
                    TestEnv = !TestEnv
                    reloadSettings()
                    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
                }
            case "sign_out":
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
                alert.addAction(UIAlertAction(title: LocalizedString("sign_out"), style: .Destructive) { action in
                    NSUserDefaults.standardUserDefaults().removeObjectForKey(TaylorR.Pref.UserToken.rawValue) // 删除token
                    userToken = DEFAULT_TOKEN
                    RKObjectManager.sharedManager().HTTPClient.setDefaultHeader("Authorization", value: "JWT \(userToken)")
                    showAlert(self, title: "已注销")
                    })
                showActionSheet(self, alert: alert)
            default:
                super.onPerform(action, indexPath: indexPath, item: item)
            }
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
}
