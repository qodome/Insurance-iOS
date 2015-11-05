//
//  Copyright © 2015年 NY. All rights reserved.
//

class EnquiryCreate: GroupedTableDetail, UINavigationControllerDelegate, UIImagePickerControllerDelegate ,CLLocationManagerDelegate, FreedomListDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {
    let locationManager = CLLocationManager()
    var imageDic: [String : UIImage] = [:]
    var brands: [PickerModel] = []
    var freedomArray: [[Freedom]] = [[]]
    var onOrOff: Bool = false
    var textField: UITextField!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (data as? Enquiry)?.city != "" && (data as? Enquiry)?.city != "上海市"  {
            showAlert(self, title: "暂不支持“上海市”以外的城市投保")
        }
    }
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        data = Enquiry()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onBackCity:", name: "city", object: nil)
        // 初始化定位
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        items = [
            [Item(title: LocalizedString("投保城市"), url: "local://")],
            [Item(title: LocalizedString("新车未上牌")),Item(title: LocalizedString("行驶证正本照片"), url: "local://")],
            [Item.emptyItem()]
        ]
        textField = UITextField()
        textField.returnKeyType = .Done
        textField.delegate = self
        textField.placeholder = "对商家说点什么"
        let buttonName = ["freedom_list", "enquiry_create"]
        for (index, value) in buttonName.enumerate() {
            let button = getButton(CGRectMake(PADDING + ((SCREEN_WIDTH - 3 * PADDING) / 2 + PADDING) * CGFloat(index), 300 + 54, (SCREEN_WIDTH - 3 * PADDING) / 2, BUTTON_HEIGHT), title: LocalizedString(value), theme: index == 0 ? STYLE_BUTTON_LIGHT : STYLE_BUTTON_DARK)
            button.addTarget(self, action: index == 0 ? "freedom" : "commit", forControlEvents: .TouchUpInside)
            tableView.addSubview(button)
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        tapGesture.delegate = self
        tableView.addGestureRecognizer(tapGesture)
    }
    
    override func onCreateLoader() -> BaseLoader {
        return HttpLoader(endpoint: endpoint, mapping: smartMapping(Enquiry.self))
    }
    
    override func onLoadSuccess<E : Enquiry>(entity: E) {
        super.onLoadSuccess(entity)
        NSNotificationCenter.defaultCenter().postNotificationName("changeIndex", object: ["id" : "\(entity.id)", "index" : "1"])
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                let accessSwitch = UISwitch()
                accessSwitch.addTarget(self, action: "switchStateChange:", forControlEvents: .ValueChanged)
                cell.accessoryView = accessSwitch
            }else {
                cell.textLabel?.text = onOrOff ? LocalizedString("车辆合格证照片") : LocalizedString("行驶证正本照片")
                let imageView = UIImageView(frame: CGRectMake(0, 0, 80, 60))
                imageView.image = UIImage(named: onOrOff ? "ic_velicense.png" : "ic_vehiclelicense.png")
                cell.accessoryView = imageView
            }
        }
        return cell
    }
    
    override func getItemView<T : Enquiry, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            cell.detailTextLabel?.text = data.city
        case 1:
            if indexPath.row == 1 && imageDic["car_license"] != nil {
                (cell.accessoryView as? UIImageView)?.image = imageDic["car_license"]
            }
        case 2:
            textField.frame = CGRectMake(PADDING, 0, SCREEN_WIDTH - 2 * PADDING, cell.frame.height)
            cell.addSubview(textField)
        default: break
        }
        return cell
    }
    
    override func onPerform<T : Item>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            switch indexPath.section {
            case 0:
                let areaList = AreaList()
                areaList.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(areaList, animated: true)
            case 1:
                let picker = UIImagePickerController()
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
                alert.addAction(UIAlertAction(title: LocalizedString("camera"), style: .Default) { action in
                    if UIImagePickerController.isSourceTypeAvailable(.Camera) { // 模拟器没有相机
                        picker.sourceType = .Camera
                        picker.delegate = self
                        self.presentViewController(picker, animated: true, completion: nil)
                    }
                    })
                alert.addAction(UIAlertAction(title: LocalizedString("photos"), style: .Default) { action in
                    picker.delegate = self
                    self.presentViewController(picker, animated: true, completion: nil)
                    })
                showActionSheet(self, alert: alert)
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            default:
                super.onPerform(action, indexPath: indexPath, item: item)
            }
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    
    func switchStateChange(sw:UISwitch) {
        onOrOff = sw.on
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 1)], withRowAnimation: .None)
    }
    
    func onBackCity(nf: NSNotification) {
        (data as? Enquiry)?.city = (nf.object!["city"] as! Province).name
        tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))?.detailTextLabel?.text = (data as! Enquiry).city
    }
    
    func freedom() {
        if imageDic["car_license"] != nil {
            let Free = FreedomList()
            Free.hidesBottomBarWhenPushed = true
            Free.imageDic = imageDic
            Free.dataArray = freedomArray
            Free.data = data
            Free.mDelegate = self
            navigationController?.pushViewController(Free, animated: true)
        } else {
            showAlert(self, title: "请上传行驶证照片")
        }
    }
    
    func commit() {
        if imageDic["car_license"] != nil {
            uploadToCloud("oss", filename: "upload/free/head.jpg", data: UIImageJPEGRepresentation(normalResImageForAsset(imageDic["car_license"]!), 0.6)!, controller: self, success: { imageUrl in
                let mEnquiry = self.data as! Enquiry
                self.loader?.create(self.data, parameters: ["content" : mEnquiry.content, "city" : mEnquiry.city, "image_urls" : "\(MEDIA_URL)/\(imageUrl)", "buyer_message" : mEnquiry.buyerMessage])
            })
        } else {
            showAlert(self, title: "请上传行驶证照片")
        }
    }
    
    func backFreedomData(dataDic: NSDictionary, dataArray: [[Freedom]]) {
        freedomArray = dataArray
        var contentUrl = ""
        for key in dataDic.allKeys {
            let mValue = dataDic["\(key)"]
            if "\(key)" == "motor_taxes" {
                contentUrl += "mandatory:\(mValue!),"
            }
            contentUrl += "\(key):\(mValue!),"
        }
        (data as? Enquiry)?.content = dataDic.count > 0 ? contentUrl : ""
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if indexPath.section == 1 && indexPath.row == 1 {
            return 80
        }
        return tableView.rowHeight
    }
    
    
    // MARK: 💜 UITableViewDataSource
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == tableView.numberOfSections - 1 ? LocalizedString("询价留言(选填)") : ""
    }
    
    // MARK: 💜 UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        if info[UIImagePickerControllerMediaType] as! CFString == kUTTypeImage {
            imageDic["car_license"] = (info[UIImagePickerControllerOriginalImage] as! UIImage)
            picker.dismissViewControllerAnimated(true, completion: nil)
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 1)], withRowAnimation: .None)
        }
    }
    
    // MARK: 💜 CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let addressDic: AnyObject? = returnAddressWithLatAndlng(locations.last!.coordinate.latitude, lng: locations.last!.coordinate.longitude)["result"]?.objectForKey("addressComponent")
        (data as? Enquiry)?.city = addressDic!["city"] as! String
        tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))?.detailTextLabel?.text = (data as? Enquiry)?.city
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        (data as? Enquiry)?.buyerMessage = textField.text!
        return true
    }
    
    // MARK: - 键盘
    func keyboardWillShow(notification: NSNotification) {
        let kbSize = notification.userInfo![UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        tableView.frame.size.height = view.frame.height - kbSize.height
    }
    
    func keyboardWillHide(notification: NSNotification) {
        tableView.frame.size.height = view.frame.height - TOOLBAR_HEIGHT
    }
    
    func tapGesture(tap: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
