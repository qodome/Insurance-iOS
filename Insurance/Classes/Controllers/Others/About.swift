//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class About: TableDetail {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [[Item(title: "review", segue: appReviewsLink())]]
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        switch getItem(indexPath).title {
        case "review":
            let star = NSMutableAttributedString(string: " ☆☆☆☆☆")
            star.addAttributes([NSForegroundColorAttributeName : UIColor.defaultColor()], range: NSMakeRange(1, star.length - 1))
            let s = NSMutableAttributedString(string: LocalizedString(getItem(indexPath).title))
            s.appendAttributedString(star)
            cell.textLabel?.attributedText = s
        default: break
        }
        return cell
    }
    
    // MARK: - 💜 UITableViewDataSource
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == tableView.numberOfSections - 1 {
            let bundle = NSBundle.mainBundle()
            let name = bundle.objectForInfoDictionaryKey("CFBundleDisplayName") as! String
            let version = bundle.objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
            let build = bundle.objectForInfoDictionaryKey("CFBundleVersion") as! String
            return "\(name) \(version) (\(build))"
        }
        return nil
    }
}
