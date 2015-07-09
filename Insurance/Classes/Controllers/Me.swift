//
//  Copyright (c) 2014年 NY. All rights reserved.
//

class Me: UserDetail {
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        items += [["settings"]]
    }
    
    override func onLoadSuccess<E : User>(entity: E) {
        super.onLoadSuccess(entity)
        title = LocalizedString("me")
    }
    
    override func getItemView<T : User, C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, data: T?, item: String, cell: C) -> UITableViewCell {
        let cell = super.getItemView(tableView, indexPath: indexPath, data: data, item: item, cell: cell)
        switch item {
        case "settings":
            let icon = FAKIonIcons.iosGearIconWithSize(CGSizeSettingsIcon.width)
            icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_BLUE))
            cell.imageView?.image = icon.imageWithSize(CGSizeSettingsIcon)
        default: break
        }
        return cell
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch getItem(indexPath) {
        case "settings":
            performSegueWithIdentifier("segue.me-settings", sender: self)
        default: break
        }
    }
}
