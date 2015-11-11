//
//  Copyright © 2015年 NY. All rights reserved.
//

class AreaList: GroupedTableDetail, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var provinces: [Province] = []
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        // 初始化定位
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
            cell.userInteractionEnabled = checkAllowLocation(false)
            if  checkAllowLocation(false) {
                cell.imageView?.image = UIImage.imageWithColor(.clearColor(), size: CGSizeSettingsIcon)
                cell.textLabel?.text = LocalizedString("定位中...")
                let activityView = UIActivityIndicatorView(frame: CGRect(origin: CGPoint(x: PADDING, y: 7), size: CGSizeSettingsIcon))
                activityView.activityIndicatorViewStyle = .Gray
                activityView.startAnimating()
                cell.contentView.addSubview(activityView)
            } else {
                let iconLocation = FAKIonIcons.androidWarningIconWithSize(CGSizeSettingsIcon.width)
                iconLocation.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(APP_COLOR))
                cell.imageView?.image = iconLocation.imageWithSize(CGSizeSettingsIcon)
                cell.textLabel?.text = LocalizedString("无法获取你的位置信息")
            }
        }
        return cell
    }
    
    override func getItemView<T : Province, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if indexPath.section == 0 {
            for subView in cell.contentView.subviews {
                if subView.isKindOfClass(UIActivityIndicatorView) {
                    subView.removeFromSuperview()
                }
            }
            let iconLocation = FAKIonIcons.locationIconWithSize(CGSizeSettingsIcon.width)
            iconLocation.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_GREEN))
            cell.imageView?.image = iconLocation.imageWithSize(CGSizeSettingsIcon)
        }
        cell.textLabel?.text = indexPath.section == 0 ? "\(data.name)" : provinces[indexPath.row].name
        return cell
    }
    
    override func onPerform<T : Item>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            if indexPath.section == 0 {
                if data != nil {
                    NSNotificationCenter.defaultCenter().postNotificationName("city", object: ["city" : data!])
                    cancel()
                }
            } else {
                if item.url.isEmpty {
                    NSNotificationCenter.defaultCenter().postNotificationName("city", object: ["city" : provinces[indexPath.row]])
                    cancel()
                } else {
                    super.onPerform(action, indexPath: indexPath, item: item)
                }
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
        return LocalizedString(section == 0 ? "定位到的位置" : "all")
    }
    
    // MARK: 💜 CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let addressDic: AnyObject? = returnAddressWithLatAndlng(locations.last!.coordinate.latitude, lng: locations.last!.coordinate.longitude)["result"]?["addressComponent"]
        data = Province()
        (data as? Province)?.name = addressDic!["city"] as! String
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .None)
    }
}
