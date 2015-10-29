//
//  Copyright © 2015年 NY. All rights reserved.
//

class AreaList: TableDetail, CLLocationManagerDelegate {
    var provinces: [Province] = []
    let locationManager = CLLocationManager()
    var address = Province()
    
    // MARK: - 💖 生命周期 (Lifecycle)
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        // 初始化定位
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        items = [[Item.emptyItem()], []] //两个组的占位
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
            items[1] += [Item(title: ProModel.name, segue: "")]
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
            cell.accessoryType = provinces[indexPath.row].cities.count == 0 ? .None : .DisclosureIndicator
            cell.textLabel?.text = provinces[indexPath.row].name
        }
        return cell
    }
    
    // MARK: - 💜 UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0  || provinces[indexPath.row].cities.count == 0 {
            NSNotificationCenter.defaultCenter().postNotificationName("city", object: nil, userInfo: ["city" : indexPath.section == 0 ? address : provinces[indexPath.row]])
            cancel()
        } else {
            let dest = mCityList()
            dest.cities = provinces[indexPath.row].cities
            dest.provinceName = provinces[indexPath.row].name
            navigationController?.pushViewController(dest, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "定位到的位置" : "全部"
    }
    
    // MARK: - 💜 CLLocationManagerDelegate
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
