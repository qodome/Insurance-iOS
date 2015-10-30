//
//  Copyright © 2015年 NY. All rights reserved.
//

class EnquiryCreate: GroupedTableDetail, UINavigationControllerDelegate, UIImagePickerControllerDelegate ,CLLocationManagerDelegate, FreedomListDelegate, PickerListDelegate {
    let locationManager = CLLocationManager()
    var imageDic: [String : UIImage] = [:]
    var brands: [PickerModel] = []
    var freedomArray: [[Freedom]] = [[]]
    
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        data = Enquiry()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onBackCity:", name: "city", object: nil)
        // 获取品牌
        let request = NSMutableURLRequest(URL: NSURL(string: "\(BASE_URL)/\(API_VERSION)/brands/")!)
        request.setValue("JWT \(userToken)", forHTTPHeaderField: "Authorization")
        let operation = RKObjectRequestOperation(request:request, responseDescriptors:generateDescriptors(smartListMapping(Brand.self)))
        operation.setCompletionBlockWithSuccess({ (operation, result) in
            let result_list = result.firstObject as! ListModel
            (self.data as! Enquiry).brand = "\((result_list.results.firstObject as! Brand).id)"
            self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2))?.detailTextLabel?.text = (result_list.results.firstObject as! Brand).name
            for  value in result_list.results {
                let pick = PickerModel()
                pick.pid = "\(value.id)"
                pick.plabel = value.name
                self.brands += [pick]
            }
            }, failure: { (operation, error) in
                showAlert(nil, title: "Error", message: error.localizedRecoverySuggestion)
        })
        operation.start()
        // 初始化定位
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        items = [
            [Item(title: LocalizedString("行驶区域"), url: "local://")],
            [Item(title: LocalizedString("行驶证正面照片"), url: "local://")],
            [Item(title: LocalizedString("车险品牌"), url: "local://")]
        ]
        let buttonName = ["freedom_list", "enquiry_create"]
        for (index, value) in buttonName.enumerate() {
            let button = getButton(CGRectMake(PADDING + ((SCREEN_WIDTH - 3 * PADDING) / 2 + PADDING) * CGFloat(index), 160 + 140, (SCREEN_WIDTH - 3 * PADDING) / 2, BUTTON_HEIGHT), title: LocalizedString(value), theme: index == 0 ? STYLE_BUTTON_LIGHT : STYLE_BUTTON_DARK)
            button.addTarget(self, action: index == 0 ? "freedom" : "commit", forControlEvents: .TouchUpInside)
            tableView.addSubview(button)
        }
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
            let imageView = UIImageView(frame: CGRectMake(0, 0, 80, 60))
            imageView.image = UIImage(named: "vehiclelicense.png")
            cell.accessoryView = imageView
        }
        return cell
    }
    
    override func getItemView<T : Enquiry, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            cell.detailTextLabel?.text = data.city
        case 1:
            if imageDic["car_license"] != nil {
                (cell.accessoryView as? UIImageView)?.image = imageDic["car_license"]
            }
        case 2:
            for brand in brands {
                if brand.pid == data.brand {
                    cell.detailTextLabel?.text = brand.plabel
                    break
                }
            }
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
            case 2:
                let pick =  PickerList()
                pick.pickerData = brands
                pick.pickerDelegate = self
                pick.titleName = (tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text)!
                pick.selectedId = (data as! Enquiry).brand
                pick.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(pick, animated: true)
            default: break
            }
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func onBackCity(nf: NSNotification) {
        (data as! Enquiry).city = (nf.userInfo!["city"] as! Province).name
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
            uploadToCloud("oss", filename: "upload/free/head.jpg", data: UIImageJPEGRepresentation(normalResImageForAsset(imageDic["car_license"]!), 0.6)!, controller: self, success: { (imageUrl) in
                let mEnquiry = self.data as! Enquiry
                (self.loader as? HttpLoader)?.post(self.data, parameters: ["content" : mEnquiry.content, "city" : mEnquiry.city, "brand" : mEnquiry.brand, "image_urls" : "\(MEDIA_URL)/\(imageUrl)"])
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
        (data as! Enquiry).content = dataDic.count > 0 ? contentUrl : ""
    }
    
    func backPickerModel(model: PickerModel) {
        tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2))?.detailTextLabel?.text = model.plabel
        (data as! Enquiry).brand = model.pid
    }
    
    // MARK: - 💜 UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return indexPath.section == 1 ? 80 : tableView.rowHeight
    }
    
    // MARK: 💜 UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        if info[UIImagePickerControllerMediaType] as! CFString == kUTTypeImage {
            imageDic["car_license"] = (info[UIImagePickerControllerOriginalImage] as! UIImage)
            picker.dismissViewControllerAnimated(true, completion: nil)
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 1)], withRowAnimation: .None)
        }
    }
    
    // MARK: 💜 CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let currentLocation = locations.last!
        let addDic = returnAddressWithLatAndlng(currentLocation.coordinate.latitude, lng: currentLocation.coordinate.longitude)
        let addressDic: AnyObject? = addDic["result"]?.objectForKey("addressComponent")
        (data as! Enquiry).city = addressDic!["city"] as! String
        tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))?.detailTextLabel?.text = (data as! Enquiry).city
    }
}
