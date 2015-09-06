//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class Profile: TableDetail, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UpdateDelegate {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [
            [
                Item(title: "avatar", dest: TextFieldUpdate.self),
                Item(title: "nickname", dest: TextFieldUpdate.self, segue: "user_update"),
                Item(title: "username")
            ],
            [
                Item(title: "gender", dest: CheckListUpdate.self, segue: "user_check"),
                Item(title: "about", dest: TextFieldUpdate.self, segue: "user_update")
            ],
            [
                Item(title: "phone_number", dest: TextFieldUpdate.self, segue: "user_update"),
                Item(title: "id_card_number", dest: TextFieldUpdate.self, segue: "user_update")
            ]
        ]
    }
    
    override func getItemView<T : User, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        switch item.title {
        case "avatar":
            cell.setTranslatesAutoresizingMaskIntoConstraints(false)
            let imageView = AvatarView(frame: CGRectMake(0, 0, 60, 60))
            imageView.image.sd_setImageWithURL(NSURL(string: data.imageUrl as String))
            cell.accessoryView = imageView
        case "gender":
            cell.detailTextLabel?.text = getString(GENDER_STRING, data.gender as String)
        default:
            cell.detailTextLabel?.text = data.valueForKey(item.title.camelCaseString()) as? String
        }
        return cell
    }
    
    // MARK: - UpdatedDelegate
    func onBackSegue(data: ModelObject?) {
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
        switch item.title {
        case "avatar":
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            startImageSheet()
        default:
            super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return getItem(indexPath).title == "avatar" ? 80 : tableView.rowHeight
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
        dest.setValue(getSelected().first!.title.camelCaseString(), forKey: "fieldName")
        if dest.isKindOfClass(UpdateController) {
            (dest as! UpdateController).delegate = self
            let endpoint = getEndpoint("users/\((data as? User)?.id)")
            dest.setValue(endpoint, forKey: "endpoint")
            dest.setValue(HttpLoader(endpoint: endpoint, type: User.self), forKey: "loader")
            if dest.isKindOfClass(CheckListUpdate) {
                dest.setValue([[Item(title: "male", segue: "check://m"), Item(title: "female", segue: "check://f")]], forKey: "items")
            }
        }
    }
}
