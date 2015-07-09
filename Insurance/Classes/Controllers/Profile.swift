//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class Profile: TableDetail, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let user = User()
        user.nickname = getString("nickname")
        user.about = getString("about")
        data = user
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData() // TIP: 放在这里而非viewDidAppear中保证回滑时候选中状态平滑消失
    }
    
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        title = LocalizedString("profile")
        items = [["avatar", "nickname", "about", "qr_code"], ["generate_template"]]
    }
    
    override func getItemView<T : User, C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, data: T?, item: String, cell: C) -> UITableViewCell {
        switch item {
        case "avatar":
            cell.setTranslatesAutoresizingMaskIntoConstraints(false)
            let imageView = AvatarView(frame: CGRectMake(0, 0, 60, 60))
            imageView.image.sd_setImageWithURL(NSURL(string: data!.imageUrl as String))
            cell.accessoryView = imageView
        case "nickname":
            cell.detailTextLabel?.text = data?.nickname as? String
            cell.accessoryType = .DisclosureIndicator
        case "about":
            cell.detailTextLabel?.text = data?.about as? String
            cell.accessoryType = .DisclosureIndicator
        default: break
        }
        return cell
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch getItem(indexPath) {
        case "avatar":
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            startImageSheet()
        case "nickname":
            performSegueWithIdentifier("segue.profile-nickname", sender: self)
        case "about":
            performSegueWithIdentifier("segue.profile-about", sender: self)
        default: break
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch getItem(indexPath) {
        case "avatar":
            return 80
        default:
            return 44
        }
    }
    
    // MARK: 💜 UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if info[UIImagePickerControllerMediaType] as! CFString == kUTTypeImage {
            // saveFile(savePath, UIImagePNGRepresentation(info[UIImagePickerControllerEditedImage] as! UIImage))
            picker.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // MARK: - 💜 场景切换 (Segue)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let dest = segue.destinationViewController as! UIViewController
        dest.setValue(data, forKey: "data")
    }
}
