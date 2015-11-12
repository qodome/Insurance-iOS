//
//  Copyright © 2015年 NY. All rights reserved.
//

enum LocationState: Int {
    case Loading, Success, Failure
}

class AreaList: GroupedTableDetail, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var provinces: [Province] = []
    var locationState = LocationState.Failure
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        // 初始化定位
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationState = checkAllowsLocation() ? .Loading : .Failure
        //
        items = [[Item(selectable: true)], []] // 两个组的占位
        let jsonData = try! String(contentsOfFile: NSBundle.mainBundle().pathForResource("city", ofType: "json")!, encoding: NSUTF8StringEncoding).dataUsingEncoding(NSUTF8StringEncoding)
        let mProArray = try! NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers) as! NSArray
        for provinceData in mProArray {
            let province = Province()
            province.setValuesForKeysWithDictionary(provinceData as! [String : AnyObject])
            var cities: [Province] = []
            for cityData in (provinceData["cities"] as! NSArray) {
                let city = Province()
                city.setValuesForKeysWithDictionary(cityData as! [String : AnyObject])
                cities += [city]
            }
            province.cities = cities
            provinces += [province]
            if cities.isEmpty {
                items[1] += [Item(title: province.name, selectable: true)]
            } else {
                items[1] += [Item(title: province.name, dest: mCityList.self, storyboard: false)]
            }
        }
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if indexPath.section == 0 {
            switch locationState {
            case .Success:
                cell.userInteractionEnabled = true
                let icon = FAKIonIcons.locationIconWithSize(CGSizeSettingsIcon.width)
                icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_GREEN))
                cell.imageView?.image = icon.imageWithSize(CGSizeSettingsIcon)
            case .Failure:
                cell.userInteractionEnabled = false
                let icon = FAKIonIcons.androidWarningIconWithSize(CGSizeSettingsIcon.width)
                icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.destructiveColor())
                cell.imageView?.image = icon.imageWithSize(CGSizeSettingsIcon)
                cell.textLabel?.text = LocalizedString("无法获取你的位置信息")
            default:
                cell.userInteractionEnabled = false
                cell.imageView?.image = .imageWithColor(.clearColor(), size: CGSizeSettingsIcon)
                cell.textLabel?.text = LocalizedString("定位中...")
                let indicator = UIActivityIndicatorView(frame: CGRectMake(PADDING + 4.5, cell.frame.height / 2 - 10, 20, 20))
                indicator.activityIndicatorViewStyle = .Gray
                indicator.startAnimating()
                cell.contentView.addSubview(indicator)
            }
        }
        return cell
    }
    
    override func getItemView<T : Province, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        cell.textLabel?.text = indexPath.section == 0 ? "\(data.name)" : provinces[indexPath.row].name
        return cell
    }
    
    override func onPerform<T : Item>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            if item.url.isEmpty {
                data = indexPath.section == 0 ? data : provinces[indexPath.row]
                NSNotificationCenter.defaultCenter().postNotificationName("city", object: ["city" : data!])
                cancel()
            } else {
                super.onPerform(action, indexPath: indexPath, item: item)
            }
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
    
    override func onSegue(segue: UIStoryboardSegue?, dest: UIViewController, id: String) {
        let province = provinces[tableView.indexPathsForSelectedRows!.first!.row]
        dest.title = province.name
        dest.setValue(province.cities, forKey: "data")
    }
    
    // MARK: - 💜 UITableViewDataSource
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return LocalizedString(section == 0 ? LocalizedString("定位到的位置") : "all")
    }
    
    // MARK: 💜 CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        let info = returnAddressWithLatAndlng(locations.last!.coordinate.latitude, lng: locations.last!.coordinate.longitude)
        let addressDic: AnyObject? = info["result"]?["addressComponent"]
        data = Province()
        (data as? Province)?.code = info["result"]?["cityCode"] as! NSNumber
        (data as? Province)?.name = addressDic!["city"] as! String
        locationState = .Success
        delay(0.5) {
            self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .None)
        }
    }
}
