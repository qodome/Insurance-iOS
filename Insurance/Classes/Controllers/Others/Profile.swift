//
//  Copyright © 2015年 NY. All rights reserved.
//

class Profile: GroupedTableDetail, UpdateDelegate {
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        items = [
            [
                Item(title: "avatar", selectable: true),
                Item(title: "nickname", dest: TextFieldUpdate.self, storyboard: false),
                Item(title: "username")
            ],
            [
                Item(title: "gender", dest: CheckListUpdate.self, storyboard: false, options: GENDER_STRING),
                Item(title: "about", dest: TextFieldUpdate.self, storyboard: false)
            ],
            [
                Item(title: "phone_number", dest: TextFieldUpdate.self, storyboard: false),
                Item(title: "id_card_number"),
                Item(title: "securyupdate", dest: SecuryUpdate.self, storyboard: false)
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
        default: break
        }
        return cell
    }
    
    override func onPerform<T : Item>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            switch item.title {
            case "avatar":
                startImageSheet(allowsEditing: true)
            default:
                super.onPerform(action, indexPath: indexPath, item: item)
            }
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
    
    override func onSegue(segue: UIStoryboardSegue?, dest: UIViewController, id: String) {
        dest.setValue(data, forKey: "data")
        if dest is UpdateController {
            dest.setValue(getSelected().first!.title, forKey: "fieldName")
            (dest as! UpdateController).delegate = self
            dest.setValue(getEndpoint("users/\((data as! User).id)"), forKey: "endpoint")
            dest.setValue(getDetailMapping(User.self), forKey: "mapping")
            if dest.isMemberOfClass(CheckListUpdate) {
                var items: [[Item]]  = [[]]
                for (key, value) in getSelected().first!.options! {
                    items[0] += [Item(title: value, url: "local://check/\(key)")]
                }
                dest.setValue(items, forKey: "items")
            }
        }
    }
    
    // MARK: - UpdatedDelegate
    func onBackSegue(data: ModelObject?) {
        self.data = data
        tableView.reloadData() // TODO: 不需要全局刷新
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return getItem(indexPath).title == "avatar" ? 80 : tableView.rowHeight
    }
    
    // MARK: 💜 UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if info[UIImagePickerControllerMediaType] as! CFString == kUTTypeImage {
            uploadToCloud("oss", filename: "upload/free/head.jpg", data:
                UIImageJPEGRepresentation(info[UIImagePickerControllerEditedImage] as! UIImage, 0.6)!, controller: self, success: { imageUrl in
                    HttpLoader(endpoint: getEndpoint("users/\((self.data as! User).id)"), type: User.self).patch(parameters: ["image_url" : "\(MEDIA_URL)/\(imageUrl)"])
                    (self.data as! User).imageUrl = "\(MEDIA_URL)/\(imageUrl)"
                    self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .None)
            })
            picker.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
