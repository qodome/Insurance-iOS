//
//  Copyright © 2015年 NY. All rights reserved.
//

class UserDetail: GroupedTableDetail {
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        let iconLikes = FAKIonIcons.iosHeartIconWithSize(CGSizeSettingsIcon.width)
        iconLikes.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_RED))
        items = [
            [Item(title: "profile", dest: Profile.self)],
            [Item(icon: iconLikes.imageWithSize(CGSizeSettingsIcon), title: "likes")]
        ]
        refreshMode = .DidAppear // TIP: 用DidAppear而非WillAppear中保证回滑时候选中状态平滑消失
    }
    
    override func onCreateLoader() -> BaseLoader {
        return HttpLoader(endpoint: endpoint, mapping: smartMapping(User.self))
    }
    
    override func onLoadSuccess<E : User>(entity: E) {
        super.onLoadSuccess(entity)
        title = entity.nickname
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        cell?.imageView?.layer.cornerRadius = 30
        cell!.imageView?.sd_setImageWithURL(NSURL(string: entity.imageUrl), placeholderImage: .imageWithColor(UIColor.whiteColor().colorWithAlphaComponent(0), size: CGSizeMake(60, 60)))
        cell?.imageView?.frame.size = CGSizeMake(60, 60)
        cell?.textLabel?.text = entity.nickname
        cell?.detailTextLabel?.text = entity.about
    }
    
    override func getItemView<T : User, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        switch item.title {
        case "likes":
            cell.detailTextLabel?.text = "\(data.likes.count)"
        default: break
        }
        return cell
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.section == 0 ? 80 : tableView.rowHeight
    }
}
