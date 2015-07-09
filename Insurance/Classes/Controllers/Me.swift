//
//  Copyright (c) 2014年 NY. All rights reserved.
//

class Me: UserDetail {
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        items += [["vehicles", "insurances", "orders"], ["settings"]]
    }
    
    override func onLoadSuccess<E : User>(entity: E) {
        super.onLoadSuccess(entity)
        title = LocalizedString("me")
    }
    
    override func getItemView<T : User, C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, data: T?, item: String, cell: C) -> UITableViewCell {
        let cell = super.getItemView(tableView, indexPath: indexPath, data: data, item: item, cell: cell)
        switch item {
        case "vehicles":
            let icon = FAKIonIcons.androidCarIconWithSize(CGSizeSettingsIcon.width)
            cell.imageView?.image = icon.imageWithSize(CGSizeSettingsIcon)
        case "insurances":
            let icon = FAKIonIcons.iosMedicalIconWithSize(CGSizeSettingsIcon.width)
            icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_GREEN))
            cell.imageView?.image = icon.imageWithSize(CGSizeSettingsIcon)
        case "orders":
            let icon = FAKIonIcons.iosPaperIconWithSize(CGSizeSettingsIcon.width)
            icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_YELLOW))
            cell.imageView?.image = icon.imageWithSize(CGSizeSettingsIcon)
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
        case "":
            performSegueWithIdentifier("segue.me-profile", sender: self)
        case "settings":
            performSegueWithIdentifier("segue.me-settings", sender: self)
        default: break
        }
    }
    
    // MARK: - 💜 场景切换 (Segue)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)        
        let dest = segue.destinationViewController as! UIViewController
        switch segue.identifier!.componentsSeparatedByString("-")[1] {
        case "profile":
            dest.setValue(data, forKey: "data")
        default: break
        }
    }
}
