//
//  Copyright © 2015年 NY. All rights reserved.
//

class About: GroupedTableDetail {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [
            [Item(title: LocalizedString("aboutus"),dest: AboutUs.self, storyboard: false)],
            [Item(title: "call", selectable: true)],
            [Item(title: "review", url: appReviewsLink())]
        ]
    }
    
    override func onPerform<T : Item>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            switch indexPath.section {
            case 1:
            UIApplication.sharedApplication().openURL(NSURL(string: "telprompt://4009683968")!)
            default:
                super.onPerform(action, indexPath: indexPath, item: item)
            }
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        switch getItem(indexPath).title {
        case "call":
            cell.detailTextLabel?.text = "400-968-3968"
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
    
    override func onSegue(segue: UIStoryboardSegue?, dest: UIViewController, id: String) {
        if dest.isKindOfClass(AboutUs.self) {
            dest.setValue("aboutus", forKey: "nameString")
            dest.setValue(LocalizedString("aboutus"), forKey: "title")
        }
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
