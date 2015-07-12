//
//  Copyright (c) 2014年 NY. All rights reserved.
//

class Settings: TableDetail {
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [["about"], ["sign_out"]]
    }
    
    override func getItemView<T : NSObject, C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, data: T?, item: String, cell: C) -> UITableViewCell {
        switch item {
        case "sign_out":
            cell.textLabel?.textColor = UIColor.destructiveColor()
        default: break
        }
        return cell
    }
    
    // MARK: - 💜 UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch getItem(indexPath) {
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
