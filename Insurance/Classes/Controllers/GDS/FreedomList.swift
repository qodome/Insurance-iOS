//
//  Copyright © 2015年 NY. All rights reserved.
//

protocol FreedomListDelegate {
    func backFreedomData(dataDic: NSDictionary, dataArray: [[Freedom]])
}

class FreedomList: GroupedTableDetail, PickerListDelegate {
    var delegate: FreedomListDelegate?
    var dataArray: [[Freedom]] = [[]]
    var imageDic: [String : UIImage] = [:]
    var dataDic = NSMutableDictionary()
    let titleArray = [LocalizedString("基础险"), LocalizedString("附加险"), LocalizedString("不计免赔"), LocalizedString("其他"), ""]
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewDidDisappear(animated: Bool) {
        delegate?.backFreedomData(dataDic, dataArray: dataArray)
    }
    
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        endpoint = getEndpoint("enquiries")
        mapping = getDetailMapping(Enquiry.self)
        dataArray = dataArray[0].isEmpty ? [[], [], [], []] : dataArray
        items = [[], [], [], []] //两个组的占位
        if dataArray[0].isEmpty {
            getDataWithFirst(0, type: true)
            
        } else {
            for (section, sectionValue) in dataArray.enumerate() {
                for rowValue in sectionValue {
                    items[section] += [Item(title: rowValue.label, dest: rowValue.accessory_type == "2" ? PickerList.self : nil, storyboard: false)]
                }
            }
        }
        let button = getBottomButton(view)
        button.setTitle(LocalizedString("enquire"), forState: .Normal)
        button.addTarget(self, action: "create", forControlEvents: .TouchUpInside)
        view.addSubview(button)
        let segmentController = HMSegmentedControl(sectionTitles: [LocalizedString("大众版"), LocalizedString("豪华版"), LocalizedString("自定义"), LocalizedString("重置")])
        segmentController.selectionIndicatorColor = .colorWithHex(APP_COLOR)
        segmentController.selectionIndicatorHeight = 2
        segmentController.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
        segmentController.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe
        segmentController.selectedTitleTextAttributes = [NSForegroundColorAttributeName : UIColor.colorWithHex(APP_COLOR)]
        segmentController.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkTextColor(), NSFontAttributeName: UIFont.systemFontOfSize(DEFAULT_FONT_SIZE_SMALL)]
        segmentController.indexChangeBlock = { index in
            self.getDataWithFirst(index, type: false)
            self.tableView.reloadData()
        }
        segmentController.frame = CGRectMake(0, STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT, view.frame.width, 36)
        view.addSubview(segmentController)
    }
    
    override func onLoadSuccess<E : Enquiry>(entity: E) {
        super.onLoadSuccess(entity)
        putString("created_time", value: entity.createdTime.formattedDateWithFormat("HH:mm"))
        cancel()
        NSNotificationCenter.defaultCenter().postNotificationName("changeIndex", object: ["id" : entity.id, "index" : "1"])
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if  dataArray[indexPath.section][indexPath.row].accessory_type == "1" {
            let Switch = UISwitch()
            Switch.tag = 10 * indexPath.section + indexPath.row
            Switch.addTarget(self, action: "switchStateChange:", forControlEvents: .ValueChanged)
            cell.accessoryView = Switch
        }
        return cell
    }
    
    override func getItemView<T : Enquiry, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if  dataArray[indexPath.section][indexPath.row].accessory_type == "1" {
            (cell.accessoryView as! UISwitch).enabled = dataArray[indexPath.section][indexPath.row].switch_enable != "0"
            (cell.accessoryView as! UISwitch).on = dataArray[indexPath.section][indexPath.row].switch_status == "1"
        } else {
            for pickValue in dataArray[indexPath.section][indexPath.row].picker_array {
                if pickValue.pid == dataArray[indexPath.section][indexPath.row].picker_pid {
                    cell.detailTextLabel?.text = pickValue.plabel
                    break
                }
            }
        }
        return cell
    }
    
    override func onSegue(segue: UIStoryboardSegue?, dest: UIViewController, id: String) {
        let indexPath = tableView.indexPathsForSelectedRows!.first!
        dest.setValue(dataArray[indexPath.section][indexPath.row].picker_array, forKey: "pickerData")
        (dest as! PickerList).delegate = self
        dest.setValue((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text)!, forKey: "title")
        dest.setValue(dataArray[indexPath.section][indexPath.row].picker_pid, forKey: "selectedId")
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func getDataWithFirst(index: Int, type: Bool) {
        dataArray = [[], [], [], []]
        let json = JSON(data: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource(["autoinsurance", "remarkinsurance", "autoinsurance", "remarkinsurance"][index], ofType: "json")!)!)
        for section in 0..<json.count {
            for row in 0..<json[section]["result"].count {
                let model = Freedom()
                model.setValuesForKeysWithDictionary(json[section]["result"][row].dictionaryObject!)
                var pid = ""
                if json[section]["result"][row]["picker_array"].isEmpty {
                    dataDic[model.name] = model.switch_status
                } else {
                    pid = model.picker_pid
                }
                var picker_array: [PickerModel] = []
                for pickRow in 0..<json[section]["result"][row]["picker_array"].count {
                    let pick = PickerModel()
                    pick.setValuesForKeysWithDictionary(json[section]["result"][row]["picker_array"][pickRow].dictionaryObject!)
                    dataDic[model.name] =  pid == pick.pid ? pick.pname : ""
                    picker_array += [pick]
                }
                model.picker_array = picker_array
                dataArray[section] += [model]
                if type {
                    items[section] += [Item(title: model.label, dest: model.accessory_type == "2" ? PickerList.self : nil, storyboard: false)]
                }
            }
        }
    }
    
    func create() {
        var contentUrl = ""
        for key in dataDic.allKeys {
            let mValue = dataDic["\(key)"]
            if "\(key)" == "motor_taxes" {
                contentUrl += "mandatory:\(mValue!),"
            }
            contentUrl += "\(key):\(mValue!),"
        }
        (data as! Enquiry).content = contentUrl
        uploadToCloud("oss", filename: "upload/free/head.jpg", data: UIImageJPEGRepresentation(imageDic["car_license"]!, 0.6)!, controller: self, success: { imageUrl in
            self.loader?.create(self.data, parameters: ["content" : (self.data as! Enquiry).content, "city" : (self.data as! Enquiry).city, "city_code" : (self.data as! Enquiry).cityCode, "image_urls" : "\(MEDIA_URL)/\(imageUrl)", "buyer_message" : (self.data as! Enquiry).buyerMessage])
        })
    }
    
    func onBackSegue(model: PickerModel) {
        let indexPath = tableView.indexPathsForSelectedRows!.first!
        let needDic = dataArray[indexPath.section][indexPath.row]
        dataDic[needDic.name] = model.pname
        var statue = "1"
        var nextID = needDic.tid
        if model.pname.isEmpty {
            statue = "0"
            switch needDic.tid {
            case "6", "7", "9","10":
                nextID = needDic.tid == "7" || needDic.tid == "10" ? "\(Int(needDic.tid)! - 1)" : "\(Int(needDic.tid)! + 1)"
                if getDicWithId(nextID).picker_pid != "0" || getDicWithId("11").switch_status == "1" || getDicWithId("12").switch_status == "1" {
                    statue = "1"
                }
            default: break
            }
        }
        switch needDic.tid {
        case "2":
            nextID = "3"
        case "6", "7":
            nextID = "8"
        case "9", "10":
            nextID = "14"
        default: break
        }
        getDicWithId(nextID).switch_enable = statue
        getDicWithId(nextID).switch_status = statue
        dataDic[getDicWithId(nextID).name] = statue
        needDic.picker_pid = model.pid
        tableView.reloadData()
    }
    
    func switchStateChange(sw:UISwitch) {
        let model = dataArray[sw.tag / 10][sw.tag % 10]
        var nextID = model.tid
        var statue = "\(sw.on.hashValue)"
        if sw.on == false {
            switch model.tid {
            case "11":
                nextID = "12"
            case "12":
                nextID = "11"
            default: break
            }
            if nextID != model.tid && (getDicWithId(nextID).switch_status == "1" || getDicWithId("9").picker_pid != "0" || getDicWithId("10").picker_pid != "0"){
                statue = "1"
            }
        }
        switch model.tid {
        case "0":
            nextID = "1"
        case "4":
            nextID = "5"
        case "11", "12":
            nextID = "14"
        default: break
        }
        getDicWithId(nextID).switch_enable = nextID != model.tid ? statue : getDicWithId(nextID).switch_enable
        getDicWithId(nextID).switch_status = statue
        dataDic[getDicWithId(nextID).name] = statue
        model.switch_status = "\(sw.on.hashValue)"
        dataDic[model.name] = model.switch_status
        tableView.reloadData()
    }
    
    func getDicWithId(mId: String) -> Freedom {
        for sectionValue in dataArray {
            for rowValue in sectionValue {
                if rowValue.tid == mId {
                    return rowValue
                }
            }
        }
        return Freedom()
    }
    
    // MARK: - 💜 UITableViewDataSource
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleArray[section]
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == tableView.numberOfSections - 1 ? BUTTON_HEIGHT : 0
    }
}
