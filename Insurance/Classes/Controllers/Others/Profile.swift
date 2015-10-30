//
//  Copyright © 2015年 NY. All rights reserved.
//

class Profile: GroupedTableDetail, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UpdateDelegate {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [
            [
                Item(title: "avatar", dest: TextFieldUpdate.self),
                Item(title: "nickname", dest: TextFieldUpdate.self, url: "user_update"),
                Item(title: "username")
            ],
            [
                Item(title: "gender", dest: CheckListUpdate.self, url: "user_check"),
                Item(title: "about", dest: TextFieldUpdate.self, url: "user_update")
            ],
            [
                Item(title: "phone_number", dest: TextFieldUpdate.self, url: "user_update"),
                Item(title: "id_card_number", dest: TextFieldUpdate.self, url: "user_update")
            ]
        ]
    }
    
    override func getItemView<T : User, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        switch item.title {
        case "avatar":
            cell.translatesAutoresizingMaskIntoConstraints = false
            let imageView = AvatarView(frame: CGRectMake(0, 0, 60, 60))
            imageView.image.sd_setImageWithURL(NSURL(string: data.imageUrl))
            cell.accessoryView = imageView
        case "gender":
            cell.detailTextLabel?.text = getString(GENDER_STRING, key: data.gender)
        default: break
        }
        return cell
    }
    
    override func onPerform<T : Item>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            switch item.title {
            case "avatar":
                startImageSheet()
            default:
                super.onPerform(action, indexPath: indexPath, item: item)
            }
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
    
    override func onSegue(segue: UIStoryboardSegue, dest: UIViewController, id: String) {
        dest.setValue(data, forKey: "data")
        dest.setValue(getSelected().first!.title.camelCaseString(), forKey: "fieldName")
        if dest.isKindOfClass(UpdateController) {
            (dest as! UpdateController).delegate = self
            let endpoint = getEndpoint("users/\((data as! User).id)")
            dest.setValue(endpoint, forKey: "endpoint")
            dest.setValue(HttpLoader(endpoint: endpoint, type: User.self), forKey: "loader")
            if dest.isKindOfClass(CheckListUpdate) {
                dest.setValue([[Item(title: "male", url: "check://m"), Item(title: "female", url: "check://f")]], forKey: "items")
            }
        }
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
        showActionSheet(self, alert: alert)
    }
    
    
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return getItem(indexPath).title == "avatar" ? 80 : tableView.rowHeight
    }
    
    // MARK: 💜 UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if info[UIImagePickerControllerMediaType] as! CFString == kUTTypeImage {
            // TODO: 上传头像
            picker.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
