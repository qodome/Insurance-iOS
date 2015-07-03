//
//  Copyright (c) 2014年 NY. All rights reserved.
//

class Settings: TableDetail {
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        title = LocalizedString("settings")
        items = [["settings"]]
    }
    
    override func getItemView<T : NSObject, C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, data: T?, item: String, cell: C) -> UITableViewCell {
        return cell
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.section == 2 && indexPath.row == 0 {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            openAppReviews()
//        }
    }
}
