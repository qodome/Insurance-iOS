//
//  Copyright © 2015年 NY. All rights reserved.
//

extension BaseController {
    
    // MARK: - 💛 自定义方法 (Custom Method)
    func returnAddressWithLatAndlng(lat: Double, lng: Double) -> NSDictionary {
        let cityRequest = NSURLRequest(URL: NSURL(string: "http://api.map.baidu.com/geocoder?location=\(lat),\(lng)&output=json")!)
        let requestData = try! NSURLConnection.sendSynchronousRequest(cityRequest, returningResponse: nil)
        let cityInfo = try! NSJSONSerialization.JSONObjectWithData(requestData, options: .MutableContainers) as! NSDictionary
        return cityInfo
    }
    
    // 判断是否定位
    func checkAllowLocation(alert: Bool) -> Bool {
        if CLLocationManager.locationServicesEnabled() && CLLocationManager.authorizationStatus() == .AuthorizedAlways || CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            return true
        }
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() != .AuthorizedAlways && CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse {
                if alert {
                    showAlert(self, title: LocalizedString("您没有设置开启定位服务"), action: UIAlertAction(title: LocalizedString("settings"), style: .Default, handler: { action in
                        UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!) // 开启设置
                    }))
                }
            }
        }
        return false
    }
}
