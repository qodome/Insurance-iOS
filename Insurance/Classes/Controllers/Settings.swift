//
//  Copyright (c) 2014年 NY. All rights reserved.
//

class Settings: TableDetail {
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [
            [Item(title: "about", dest: About.self)],
            [Item(title: "sign_out", color: UIColor.destructiveColor())]
        ]
    }
    
    // MARK: - 💜 UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch getItem(indexPath).title {
        case "sign_out":
            tableView.deselectRowAtIndexPath(indexPath, animated: true) // 取消选中
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            alert.addAction(UIAlertAction(title: LocalizedString("sign_out"), style: .Destructive) { (action) in
                NSUserDefaults.standardUserDefaults().removeObjectForKey(TaylorR.Pref.UserToken.rawValue)
                userToken = DEFAULT_TOKEN
                RKObjectManager.sharedManager().HTTPClient.setDefaultHeader("Authorization", value: String(format: "Token %@", userToken))
                userId = 0
//                userId = getInteger(TaylorR.Pref.UserId.rawValue)
                showAlert(self, title: "已注销")
                })
            showActionSheet(self, alert)
        default:
            super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        }
    }
}
