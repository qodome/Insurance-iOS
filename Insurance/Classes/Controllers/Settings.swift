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
        default:
            cell.accessoryType = .DisclosureIndicator
        }
        return cell
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch getItem(indexPath) {
        case "about":
            performSegueWithIdentifier("segue.settings-about", sender: self)
        case "sign_out":
            tableView.deselectRowAtIndexPath(indexPath, animated: true) // 取消选中
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            alert.addAction(UIAlertAction(title: LocalizedString("sign_out"), style: .Destructive) { (action) in
                NSUserDefaults.standardUserDefaults().removeObjectForKey(TaylorR.Pref.UserToken.rawValue)
                })
            showActionSheet(self, alert)
        default: break
        }
    }
}
