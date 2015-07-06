//
//  Copyright (c) 2014年 NY. All rights reserved.
//

class Me: UserDetail {
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        items += [["settings"], ["sign_out"]]
    }
    
    override func onLoadSuccess<E : User>(entity: E) {
        super.onLoadSuccess(entity)
        title = LocalizedString("me")
    }
    
    override func getItemView<T : User, C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, data: T?, item: String, cell: C) -> UITableViewCell {
        switch item {
        case "sign_out":
            cell.textLabel?.textColor = UIColor.redColor()
        default:
            cell.accessoryType = .DisclosureIndicator
        }
        return cell
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch getItem(indexPath) {
        case "settings":
            performSegueWithIdentifier("segue.me-settings", sender: self)
        case "sign_out":
            performSegueWithIdentifier("segue.me-intro", sender: self)
        default: break
        }
    }
}
