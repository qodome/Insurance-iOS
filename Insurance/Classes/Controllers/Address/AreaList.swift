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
        for province in entity.results {
            if (province as! Province).cities.results.count == 1 {
                items[1] += [Item(title: ((province as! Province).cities.results.firstObject as! Province).name, selectable: true)]
            } else {
                items[1] += [Item(title: province.name, dest: mCityList.self, storyboard: false)]
            }
        }
        tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: .None)
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
            LOG((data.results[indexPath.row] as! Province).state)
        }
        return cell
    }
    
    override func onPerform<T : Item>(action: Action, indexPath: NSIndexPath, item: T) {
        switch action {
        case .Open:
            if item.url.isEmpty {
                locationData = indexPath.section == 0 ? locationData : ((data as! ListModel).results[(indexPath.row)] as! Province).cities.results.firstObject as! Province
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
}
