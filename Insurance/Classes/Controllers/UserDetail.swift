//
//  Copyright (c) 2014年 NY. All rights reserved.
//

class UserDetail: TableDetail {
    
    var avatar: AvatarView!
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [["vehicles", "insurances", "orders"]]
        endpoint = getEndpoint("users/\(userId)")
        refreshMode = .WillAppear
        avatar = AvatarView(frame: CGRectMake((view.frame.width - 150) / 2, 0, 150, 150))
        avatar.image.image = UIImage.imageWithColor(UIColor.colorWithHex(APP_COLOR))
        tableView.addSubview(avatar)
    }
    
    override func onCreateLoader() -> BaseLoader {
        return HttpLoader(endpoint: endpoint, mapping: smartMapping(User.self))
    }
    
    override func onLoadSuccess<E : User>(entity: E) {
        super.onLoadSuccess(entity)
        title = entity.nickname as String
        avatar.image.sd_setImageWithURL(NSURL(string: entity.imageUrl as String))
    }
    
    override func getItemView<T : User, C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, data: T?, item: String, cell: C) -> UITableViewCell {
        cell.accessoryType = .DisclosureIndicator
        var icon: FAKIcon? = nil
        switch item {
        case "vehicles":
            icon = FAKIonIcons.androidCarIconWithSize(CGSizeSettingsIcon.width)
            icon?.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_RED))
        case "insurances":
            icon = FAKIonIcons.iosMedicalIconWithSize(CGSizeSettingsIcon.width)
            icon?.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_GREEN))
        case "orders":
            icon = FAKIonIcons.iosPaperIconWithSize(CGSizeSettingsIcon.width)
            icon?.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_YELLOW))
        default: break
        }
        cell.imageView?.image = icon?.imageWithSize(CGSizeSettingsIcon)
        return cell
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 150 : 20
    }
}
