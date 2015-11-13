//
//  Copyright © 2015年 NY. All rights reserved.
//

class EnquiryCreate: CreateController, CLLocationManagerDelegate, FreedomListDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {
    let locationManager = CLLocationManager()
    var imageDic: [String : UIImage] = [:]
    var freedomArray: [[Freedom]] = [[]]
    var onOrOff: Bool = false
    var textField = UITextField()
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (data as? Enquiry)?.city != "" && (data as? Enquiry)?.status == "0"  {
            showAlert(self, title: "暂不支持“\((data as? Enquiry)!.city)”投保")
        }
    }
    
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        mapping = smartMapping(Enquiry.self)
        data = Enquiry()
        // 初始化定位
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        items = [
            [
                Item(title: LocalizedString("投保城市"), dest: AreaList.self, storyboard: false),
                Item(title: LocalizedString("新车未上牌")),
                Item(title: LocalizedString("行驶证正本照片"), selectable: true)
            ],
            [
                Item.emptyItem()
            ]
        ]
        let imageView = ImageView(frame: CGRectMake(0, 0, view.frame.width, view.frame.width * 0.4))
        imageView.image = UIImage(named: "ic_banner.png")
        tableView.tableHeaderView = imageView
        textField.returnKeyType = .Done
        textField.delegate = self
        textField.placeholder = "对商家说点什么(选填)"
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        tapGesture.delegate = self
        tableView.addGestureRecognizer(tapGesture)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onBackCity:", name: "city", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        delay(0.2) {
            checkAllowsLocation(allowsAlert: true)
            let y = CGRectGetMaxY(self.tableView.rectForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1))) + PADDING_INNER
            let buttonName = ["freedom_list", "enquire"]
            for (index, value) in buttonName.enumerate() {
                let width = (self.view.frame.width - 2 * PADDING - PADDING_INNER) / 2
                let button = QuickButton(frame: CGRectMake(PADDING + (width
                    + PADDING_INNER) * CGFloat(index), y, width, BUTTON_HEIGHT), title: LocalizedString(value), theme: index == 0 ? STYLE_BUTTON_LIGHT : STYLE_BUTTON_DARK)
                button.addTarget(self, action: index == 0 ? "freedom" : "create", forControlEvents: .TouchUpInside)
                self.tableView.addSubview(button)
            }
        }
    }
    
    override func onLoadSuccess<E : Enquiry>(entity: E) {
        super.onLoadSuccess(entity)
        putString("created_time", value: entity.createdTime.formattedDateWithFormat("HH:mm"))
        NSNotificationCenter.defaultCenter().postNotificationName("changeIndex", object: ["id" : entity.id, "index" : "1"])
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            switch indexPath.row {
            case 1 :
                let accessSwitch = UISwitch()
                accessSwitch.addTarget(self, action: "switchStateChange:", forControlEvents: .ValueChanged)
                cell.accessoryView = accessSwitch
            case 2 :
                cell.textLabel?.text = onOrOff ? LocalizedString("车辆合格证照片") : LocalizedString("行驶证正本照片")
                let imageView = UIImageView(frame: CGRectMake(0, 0, 80, 60))
                imageView.image = UIImage(named: onOrOff ? "ic_velicense.png" : "ic_vehiclelicense.png")
                cell.accessoryView = imageView
            default :
                break
            }
        case 1:
            textField.frame = CGRectMake(PADDING, 0, view.frame.width - 2 * PADDING, cell.frame.height)
            cell.addSubview(textField)
        default: break
        }
        return cell
    }
    
    override func getItemView<T : Enquiry, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0 :
                cell.detailTextLabel?.text = checkAllowsLocation() ? data.city : "定位服务关闭"
            case 2 :
                if imageDic["car_license"] != nil {
                    (cell.accessoryView as? UIImageView)?.image = imageDic["car_license"]
                }
            default: break
            }
        }
        return cell
    }
    
    override func onPerform<T : Item>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            if indexPath.section == 0 && indexPath.row == 2 {
                startImageSheet()
            } else {
                super.onPerform(action, indexPath: indexPath, item: item)
            }
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
    
    override func onSegue(segue: UIStoryboardSegue?, dest: UIViewController, id: String) {
        if dest.isKindOfClass(FreedomList.self) {
            dest.setValue(data, forKey: "data")
            dest.setValue(imageDic, forKey: "imageDic")
            dest.setValue(freedomArray, forKey: "dataArray")
            (dest as! FreedomList).delegate = self
        }
    }
    
    override func create() {
        if imageDic["car_license"] != nil {
            uploadToCloud("oss", filename: "upload/free/head.jpg", data: UIImageJPEGRepresentation(imageDic["car_license"]!, 0.6)!, controller: self, success: { imageUrl in
                let mEnquiry = self.data as! Enquiry
                self.loader?.create(self.data, parameters: ["content" : mEnquiry.content, "city" : mEnquiry.city, "city_code" : mEnquiry.cityCode, "image_urls" : "\(MEDIA_URL)/\(imageUrl)", "buyer_message" : mEnquiry.buyerMessage])
            })
        } else {
            showAlert(self, title: onOrOff ? "请上传车辆合格证照片" : "请上传行驶证正本照片")
        }
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func switchStateChange(sw:UISwitch) {
        onOrOff = sw.on
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: .None)
    }
    
    func onBackCity(nf: NSNotification) {
        (data as? Enquiry)?.city = (nf.object!["city"] as! Province).name
        (data as? Enquiry)?.cityCode = (nf.object!["city"] as! Province).code
        (data as? Enquiry)?.status = "\((nf.object!["city"] as! Province).state)" // Enqury 中得status 没有用到 暂时存储省份的状态，为了是都提示用，不额外创建变量
        tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))?.detailTextLabel?.text = (data as! Enquiry).city
    }
    
    func freedom() {
        if imageDic["car_license"] != nil {
            startActivity(Item(dest: FreedomList.self, storyboard: false))
        } else {
            showAlert(self, title: onOrOff ? "请上传车辆合格证照片" : "请上传行驶证正本照片")
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
        return indexPath.section == 0 && indexPath.row == 2 ? 80 :tableView.rowHeight
    }
    
    // MARK: 💜 UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        if info[UIImagePickerControllerMediaType] as! CFString == kUTTypeImage {
            imageDic["car_license"] = (info[UIImagePickerControllerOriginalImage] as! UIImage)
            picker.dismissViewControllerAnimated(true, completion: nil)
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: .None)
        }
    }
    
    // MARK: 💜 CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let info = getAddress(latitude: locations.last!.coordinate.latitude, longitude: locations.last!.coordinate.longitude)
        let addressDic: AnyObject? = info["result"]?["addressComponent"]
        (data as? Enquiry)?.cityCode = info["result"]?["cityCode"] as! NSNumber
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
        (data as? Enquiry)?.buyerMessage = textField.text!
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return NSStringFromClass(touch.view!.classForCoder) == "UITableViewCellContentView" ? false : true
    }
}
