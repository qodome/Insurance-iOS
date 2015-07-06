//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class Profile: TableDetail, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let avatarPath = PATH_DOCUMENTS.stringByAppendingPathComponent("avatar.png")
    let QRCodePath = PATH_DOCUMENTS.stringByAppendingPathComponent("qr_code.png")
    var savePath = ""
    
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
        // navigationController?.navigationBar.translucent = false
        // navigationController?.navigationBar.barTintColor = UIColor.colorWithHex(APP_COLOR)
        // navigationController?.navigationBar.barStyle = .Black
        // navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func getItemView<T : User, C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, data: T?, item: String, cell: C) -> UITableViewCell {
        switch item {
        case "avatar":
            cell.setTranslatesAutoresizingMaskIntoConstraints(false)
            let imageView = AvatarView(frame: CGRectMake(0, 0, 60, 60))
            imageView.image.image = UIImage(contentsOfFile: avatarPath)
            cell.accessoryView = imageView
        case "nickname":
            cell.detailTextLabel?.text = data?.nickname as? String
            cell.accessoryType = .DisclosureIndicator
        case "about":
            cell.detailTextLabel?.text = data?.about as? String
            cell.accessoryType = .DisclosureIndicator
        case "qr_code":
            let imageView = UIImageView(frame: CGRectSettingsIcon)
            imageView.contentMode = .ScaleAspectFit
            let image = UIImage(contentsOfFile: QRCodePath)
            imageView.image = image != nil ? image : UIImage.imageWithColor(UIColor.colorWithHex(APP_COLOR)) // TIP: 设定图片背景色的方式选中会盖掉
            cell.accessoryView = imageView
        case "generate_template":
            cell.textLabel?.textColor = UIColor.defaultColor()
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
        alert.addAction(UIAlertAction(title: LocalizedString("cancel"), style: .Cancel, handler: nil))
        alert.popoverPresentationController?.sourceView = view // 适配iPad
        alert.popoverPresentationController?.sourceRect = CGRectMake(0, 0, view.frame.width, view.frame.height / 2)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch getItem(indexPath) {
        case "avatar":
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            savePath = avatarPath
            startImageSheet()
        case "nickname":
            performSegueWithIdentifier("segue.profile-nickname", sender: self)
        case "about":
            performSegueWithIdentifier("segue.profile-about", sender: self)
        case "qr_code":
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            savePath = QRCodePath
            startImageSheet()
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
            saveFile(savePath, UIImagePNGRepresentation(info[UIImagePickerControllerEditedImage] as! UIImage))
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
