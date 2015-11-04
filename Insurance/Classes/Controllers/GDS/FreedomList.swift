//
//  Copyright © 2015年 NY. All rights reserved.
//

protocol FreedomListDelegate {
    func backFreedomData(dataDic: NSDictionary, dataArray: [[Freedom]])
}

class FreedomList: GroupedTableDetail, PickerListDelegate {
    var mDelegate: FreedomListDelegate?
    var dataArray: [[Freedom]] = [[]]
    var imageDic: [String : UIImage] = [:]
    var dataDic = NSMutableDictionary()
    var selectedIndexPath = NSIndexPath()
    let titleArray: [String] = ["基础险", "附加险", "不计免赔", "其他", ""]
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewDidDisappear(animated: Bool) {
        mDelegate?.backFreedomData(dataDic, dataArray: dataArray)
    }
    
    // MARK: - 🐤 Taylor
    override func onPrepare() {
        super.onPrepare()
        dataArray = dataArray[0].isEmpty ? [[], [], [], []] : dataArray
        items = [[], [], [], [], [.emptyItem()]] //两个组的占位
        if dataArray[0].isEmpty {
            let jsonData = try! String(contentsOfFile: NSBundle.mainBundle().pathForResource("autoinsurance", ofType: "json")!, encoding: NSUTF8StringEncoding).dataUsingEncoding(NSUTF8StringEncoding)
            let temp = try! NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers) as! [NSDictionary]
            for (section, sectionValue) in temp .enumerate() {
                for rowValue in sectionValue["result"] as! [NSDictionary] {
                    let model = Freedom()
                    model.setValuesForKeysWithDictionary(rowValue as! [String : AnyObject])
                    let pickArray = rowValue["picker_array"] as! [[String : AnyObject]]
                    var pid = ""
                    if pickArray.isEmpty { // FIXME: 用isEmpty，先不要用NSArray
                        dataDic[model.name] = model.switch_status
                    } else {
                        pid = model.picker_pid
                    }
                    var picker_array: [PickerModel] = []
                    for pickValue in pickArray {
                        let pick = PickerModel()
                        pick.setValuesForKeysWithDictionary(pickValue)
                        if pid == pick.pid {
                            dataDic[model.name] = pick.pname
                        }
                        picker_array += [pick]
                    }
                    model.picker_array = picker_array
                    dataArray[section] += [model]
                    items[section] += [Item(title: model.label, url: model.accessory_type == "1" ? "" : "local://")]
                }
            }
        } else {
            for (section, sectionValue) in dataArray.enumerate() {
                for rowValue in sectionValue {
                    items[section] += [Item(title: rowValue.label, url: rowValue.accessory_type == "1" ? "" : "local://")]
                }
            }
        }
    }
    
    override func onCreateLoader() -> BaseLoader {
        return HttpLoader(endpoint: getEndpoint("enquiries"), mapping: smartMapping(Enquiry.self))
    }
    
    override func onLoadSuccess<E : Enquiry>(entity: E) {
        super.onLoadSuccess(entity)
        cancel()
        NSNotificationCenter.defaultCenter().postNotificationName("changeIndex", object: ["id" : "\(entity.id)", "index" : "1"])
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if indexPath.section != tableView.numberOfSections - 1 {
            if  dataArray[indexPath.section][indexPath.row].accessory_type == "1" {
                let Switch = UISwitch()
                Switch.tag = 10 * indexPath.section + indexPath.row
                Switch.addTarget(self, action: "switchStateChange:", forControlEvents: .ValueChanged)
                cell.accessoryView = Switch
            }
        } else {
            let button = getButton(cell.frame, title: LocalizedString("enquiry_create"), theme: STYLE_BUTTON_DARK)
            button.addTarget(self, action: "enquiryCreate", forControlEvents: .TouchUpInside)
            cell.contentView.addSubview(button)
        }
        return cell
    }
    
    override func getItemView<T : Enquiry, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if indexPath.section != tableView.numberOfSections - 1 {
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
        }
        return cell
    }
    
    override func onPerform<T : Item>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            selectedIndexPath = indexPath
            if dataArray[indexPath.section][indexPath.row].accessory_type == "2" {
                let pick =  PickerList()
                pick.pickerData = dataArray[indexPath.section][indexPath.row].picker_array
                pick.pickerDelegate = self
                pick.titleName = (tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text)!
                pick.selectedId = dataArray[indexPath.section][indexPath.row].picker_pid
                pick.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(pick, animated: true)
            }
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func enquiryCreate() {
        var contentUrl = ""
        for key in dataDic.allKeys {
            let mValue = dataDic["\(key)"]
            if "\(key)" == "motor_taxes" {
                contentUrl += "mandatory:\(mValue!),"
            }
            contentUrl += "\(key):\(mValue!),"
        }
        (data as! Enquiry).content = contentUrl
        uploadToCloud("oss", filename: "upload/free/head.jpg", data: UIImageJPEGRepresentation(normalResImageForAsset(imageDic["car_license"]!), 0.6)!, controller: self, success: { imageUrl in
            (self.loader as? HttpLoader)?.post(parameters: ["content" : (self.data as! Enquiry).content, "city" : (self.data as! Enquiry).city, "image_urls" : "\(MEDIA_URL)/\(imageUrl)","buyer_message" : (self.data as! Enquiry).buyerMessage])
        })
    }
    
    func backPickerModel(model: PickerModel) {
        let needDic = dataArray[selectedIndexPath.section][selectedIndexPath.row]
        dataDic[needDic.name] = model.pname
        var statue = "1"
        var nextID = needDic.tid
        if model.pname == "" {
            statue = "0"
            switch needDic.tid {
            case "6", "7", "9","10":
                nextID = needDic.tid == "7" || needDic.tid == "10" ? "\(Int(needDic.tid as String)! - 1)" : "\(Int(needDic.tid as String)! + 1)"
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
            if getDicWithId(nextID).switch_status == "1" || getDicWithId("9").picker_pid != "0" || getDicWithId("10").picker_pid != "0" {
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
        getDicWithId(nextID).switch_enable = statue
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
}
