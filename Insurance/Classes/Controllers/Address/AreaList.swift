//
//  Copyright © 2015年 NY. All rights reserved.
//

class AreaList: GroupedTableDetail, CLLocationManagerDelegate {
    var provinces: [Province] = []
    let locationManager = CLLocationManager()
    var address = Province()
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        // 初始化定位
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        items = [[.emptyItem()], []] //两个组的占位
        let jsonData = try! String(contentsOfFile: NSBundle.mainBundle().pathForResource("city", ofType: "json")!, encoding: NSUTF8StringEncoding).dataUsingEncoding(NSUTF8StringEncoding)
        let mProArray = try! NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers) as! NSArray
        for value in mProArray {
            let ProModel = Province()
            ProModel.setValuesForKeysWithDictionary(value as! [String : AnyObject])
            var cityArray: [Province] = []
            for city in (value["cities"] as! NSArray) {
                let cityModel = Province()
                cityModel.setValuesForKeysWithDictionary(city as! [String : AnyObject])
                cityArray += [cityModel]
            }
            ProModel.cities = cityArray
            provinces += [ProModel]
            items[1] += [Item(title: ProModel.name, url: "local://")]
        }
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        var locationCell:LocationCell
        if indexPath.section == 0 {
            locationCell = LocationCell(style: .Default, reuseIdentifier: cellId)
            if address.name != "" {
                locationCell.changeTitle("\(address.name)")
            }
            return locationCell
        } else {
            cell.accessoryType = provinces[indexPath.row].cities.isEmpty ? .None : .DisclosureIndicator
            cell.textLabel?.text = provinces[indexPath.row].name
        }
        return cell
    }
    
    override func onPerform<T : Item>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            if indexPath.section == 0 || provinces[indexPath.row].cities.isEmpty {
                NSNotificationCenter.defaultCenter().postNotificationName("city", object: nil, userInfo: ["city" : indexPath.section == 0 ? address : provinces[indexPath.row]])
                cancel()
            } else {
                let dest = mCityList()
                dest.title = provinces[indexPath.row].name
                dest.cities = provinces[indexPath.row].cities
                navigationController?.pushViewController(dest, animated: true)
            }
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
    
    // MARK: - 💜 UITableViewDataSource
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? LocalizedString("定位到的位置") : LocalizedString("all")
    }
    
    // MARK: 💜 CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let currentLocation:CLLocation = locations.last!
        let addDic:NSDictionary = returnAddressWithLatAndlng(currentLocation.coordinate.latitude, lng: currentLocation.coordinate.longitude)
        let addressDic: AnyObject? = addDic["result"]?["addressComponent"]
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! LocationCell
        let locationAddress = Province()
        locationAddress.name = addressDic!["city"] as! String
        address = locationAddress
        cell.changeTitle("\(address.name)")
    }
}
