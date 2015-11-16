//
//  Copyright © 2015年 NY. All rights reserved.
//

class AreaList: GroupedTableDetail, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var locationState = LocationState.Failure
    var locationData = Province()
    
    // MARK: - 🐤 继承 Taylor
    override func onPrepare() {
        super.onPrepare()
        title = LocalizedString("region")
        endpoint = getEndpoint("provinces")
        mapping = smartListMapping(Province.self, children: [RKChild(path: "cities", type: Province.self, isList: true)])
        refreshMode = .DidLoad
        // 初始化定位
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationState = checkAllowsLocation() ? .Loading : .Failure
        //
        items = [[Item(selectable: true)], []] // 两个组的占位
    }
    
    override func onLoadSuccess<E : ListModel>(entity: E) {
        super.onLoadSuccess(entity)
        for province in entity.results as! [Province] {
            if province.cities.results.count == 1 {
                items[1] += [Item(title: (province.cities.results[0] as! Province).name, selectable: true)]
            } else {
                items[1] += [Item(title: province.name, dest: mCityList.self, storyboard: false)]
            }
        }
        tableView.reloadData()
    }
    
    override func prepareGetItemView<C : UITableViewCell>(tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if indexPath.section == 0 {
            switch locationState {
            case .Success:
                cell.userInteractionEnabled = true
                let icon = FAKIonIcons.androidPinIconWithSize(CGSizeSettingsIcon.width)
                icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.colorWithHex(XIAOMAR_GREEN))
                cell.imageView?.image = icon.imageWithSize(CGSizeSettingsIcon)
            case .Failure:
                cell.userInteractionEnabled = false
                let icon = FAKIonIcons.androidAlertIconWithSize(CGSizeSettingsIcon.width)
                icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.systemDestructiveColor())
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
    
    override func getItemView<T : ListModel, C : UITableViewCell>(data: T, tableView: UITableView, indexPath: NSIndexPath, item: Item, cell: C) -> UITableViewCell {
        if indexPath.section == 0 && locationState == .Success {
            cell.textLabel?.text = locationData.name
        } else {
            delay(0.1) {
                if [2, 3].contains((data.results[indexPath.row] as! Province).state) {
                    let button = getAppStoreButton(LocalizedString("费改"))
                    button.frame.origin.x = CGRectGetMaxX((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.frame)!) + PADDING
                    button.center.y = tableView.cellForRowAtIndexPath(indexPath)!.textLabel!.center.y
                    button.addTarget(self, action: "feigai", forControlEvents: .TouchUpInside)
                    cell.contentView.addSubview(button)
                }
            }
        }
        return cell
    }
    
    override func onPerform<T : Item>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            if item.url.isEmpty {
                locationData = indexPath.section == 0 ? locationData : ((data as! ListModel).results[(indexPath.row)] as! Province).cities.results[0] as! Province
                NSNotificationCenter.defaultCenter().postNotificationName("city", object: ["city" : locationData])
                cancel()
            } else {
                super.onPerform(action, indexPath: indexPath, item: item)
            }
        default:
            super.onPerform(action, indexPath: indexPath, item: item)
        }
    }
    
    override func onSegue(segue: UIStoryboardSegue?, dest: UIViewController, id: String) {
        let indexPath = tableView.indexPathsForSelectedRows?.first!
        dest.title = ((data as! ListModel).results[(indexPath?.row)!] as! Province).name
        dest.setValue(((data as! ListModel).results[(indexPath?.row)!] as! Province).cities.results, forKey: "data")
    }
    
    // MARK: - 💜 UITableViewDataSource
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return LocalizedString(section == 0 ? LocalizedString("定位到的位置") : "all")
    }
    
    // MARK: 💜 CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        let info = getAddress(latitude: locations.last!.coordinate.latitude, longitude: locations.last!.coordinate.longitude)
        let addressDic: AnyObject? = info["result"]?["addressComponent"]
        locationData.code = info["result"]?["cityCode"] as! NSNumber
        locationData.name = addressDic!["city"] as! String
        locationState = .Success
        delay(0.5) {
            self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .None)
        }
    }
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func feigai() {
        showAlert(self, title: "费改税，也称税费改革，是指在对现有的政府收费进行清理整顿的基础上，用税收取代一些具有税收特征的收费，通过进一步深化财税体制改革，初步建立起以税收为主，少量的、必要的政府收费为辅的政府收入体系。其实质是为规范政府收入机制而必须采取的一项重大改革举措。")
    }
}
