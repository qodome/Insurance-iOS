//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class Profile: TableDetail, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UpdateDelegate {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [["avatar", "nickname", "username"], ["gender", "about"]]
    }
    
    override func getItemView<T : User, C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, data: T?, item: String, cell: C) -> UITableViewCell {
        switch item {
        case "avatar":
            cell.setTranslatesAutoresizingMaskIntoConstraints(false)
            let imageView = AvatarView(frame: CGRectMake(0, 0, 60, 60))
            imageView.image.sd_setImageWithURL(NSURL(string: data!.imageUrl as String))
            cell.accessoryView = imageView
        case "gender":
            cell.detailTextLabel?.text = getString(GENDER_STRING, data?.gender as? String)
        default:
            cell.detailTextLabel?.text = data?.valueForKey(item) as? String
        }
        return cell
    }
    
    // MARK: - UpdatedDelegate
    func onBackSegue(data: NSObject?) {
        self.data = data
        tableView.reloadData()
    }
    
    // MARK: -
    func startImageSheet() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        alert.addAction(UIAlertAction(title: LocalizedString("camera"), style: .Default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.Camera) { // 模拟器没有相机
                picker.sourceType = .Camera
                picker.delegate = self
                self.presentViewController(picker, animated: true, completion: nil)
            }
            })
        alert.addAction(UIAlertAction(title: LocalizedString("photos"), style: .Default) { (action) in
            picker.delegate = self
            self.presentViewController(picker, animated: true, completion: nil)
            })
        showActionSheet(self, alert)
    }
    
    // MARK: - 💜 UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = getItem(indexPath)
        switch item {
        case "avatar":
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            startImageSheet()
        case "about":
            performSegueWithIdentifier("segue.profile-user_edit", sender: self)
        default:
            super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return getItem(indexPath) == "avatar" ? 80 : 44
    }
    
    // MARK: 💜 UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if info[UIImagePickerControllerMediaType] as! CFString == kUTTypeImage {
            // TODO: 上传头像
            picker.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // MARK: - 💜 场景切换 (Segue)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let dest = segue.destinationViewController as! UIViewController
        dest.setValue(data, forKey: "data")
        dest.setValue(getItem(tableView.indexPathForSelectedRow()!), forKey: "fieldName")
        if dest.isKindOfClass(UpdateController) {
            (dest as! UpdateController).delegate = self
            (dest as! UpdateController).endpoint = getEndpoint("users/\((data as! User).id)")
            (dest as! UpdateController).loader = HttpLoader(endpoint: getEndpoint("users/\((data as! User).id)"), type: User.self)
        }
    }
}
