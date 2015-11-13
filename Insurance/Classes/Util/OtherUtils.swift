//
//  Copyright © 2015年 NY. All rights reserved.
//

// 只处理价格
func getFormatterPrice(origial: NSNumber) -> String {
    let formatter = NSNumberFormatter()
    formatter.numberStyle = .CurrencyStyle
    return  formatter.stringFromNumber(NSNumber(double: origial.doubleValue / 100))!
}

// 获取状态的中文显示字
func getStatusString(status: NSNumber) -> String {
    let jsonData = try! String(contentsOfFile: NSBundle.mainBundle().pathForResource("order_status", ofType: "json")!, encoding: NSUTF8StringEncoding).dataUsingEncoding(NSUTF8StringEncoding)
    let temp = try! NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers) as! [String : String]
    return temp["\(status)"] == nil ? "" :temp["\(status)"]!
}
