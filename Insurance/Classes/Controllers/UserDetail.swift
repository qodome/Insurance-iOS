//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class UserDetail: TableDetail {
    // MARK: - 💖 生命周期 (Lifecycle)
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        endpoint = getEndpoint("users/\(userId)")
//    }
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [["profile"], ["likes"]]
        endpoint = getEndpoint("users/\(userId)")
        refreshMode = .DidAppear // TIP: 用DidAppear而非WillAppear中保证回滑时候选中状态平滑消失
    }
    
    override func onCreateLoader() -> BaseLoader {
        return HttpLoader(endpoint: endpoint, mapping: smartMapping(User.self))
    }
    
    override func onLoadSuccess<E : User>(entity: E) {
        super.onLoadSuccess(entity)
        title = entity.nickname as String
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        cell?.imageView?.layer.cornerRadius = 30
        cell!.imageView?.sd_setImageWithURL(NSURL(string: entity.imageUrl as String), placeholderImage: UIImage.imageWithColor(UIColor.whiteColor().colorWithAlphaComponent(0), size: CGSizeMake(60, 60)))
        cell?.imageView?.frame.size = CGSizeMake(60, 60)
        cell?.textLabel?.text = entity.nickname as String
        cell?.detailTextLabel?.text = entity.about as String
    }
    
    override func getItemView<T : User, C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, data: T?, item: String, cell: C) -> UITableViewCell {
        switch item {
        case "likes":
            let icon = FAKIonIcons.iosHeartIconWithSize(CGSizeSettingsIcon.width)
            icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_RED))
            cell.imageView?.image = icon.imageWithSize(CGSizeSettingsIcon)
        default: break
        }
        return cell
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.section == 0 ? 80 : 44 // TODO: 怎么不固定44而是动态的
    }
}
