//
//  Copyright © 2015年 NY. All rights reserved.
//

// 只处理价格
func getFormatterPrice(origial: NSNumber) -> String {
    let formatter = NSNumberFormatter()
    formatter.numberStyle = .DecimalStyle
    formatter.maximumFractionDigits = 2
    return  "￥\(formatter.stringFromNumber(NSNumber(double: origial.doubleValue / 100))!.stringByReplacingOccurrencesOfString(",", withString: ""))"
}

// 获取状态的中文显示字
func getStatusString(status: NSNumber) -> String {
    let json = JSON(data: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("order_status", ofType: "json")!)!)
    return json["\(status)"].string ?? ""
}

// 类似AppStore上获取按钮
func getAppStoreButton(title:String, color: UIColor = .systemDefaultColor()) -> UIButton {
    let button = UIButton()
    button.setTitle(title, forState: .Normal)
    button.setTitleColor(color, forState: .Normal)
    button.setTitleColor(.whiteColor(), forState: .Highlighted)
    button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 13) // iOS9 SanFrancisco .SFUIText-Regular .SFUIText-Semibold .SFUIText-Heavy iOS8 HelveticaNeue-Bold
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10)
    button.sizeToFit()
    button.layer.masksToBounds = true  // 不写这个方法，高亮状态button背景是填充满的，没有截取
    button.layer.cornerRadius = 4
    button.layer.borderColor = color.CGColor
    button.layer.borderWidth = 1
    button.frame.size.height = 26 // AppStore更新按钮和进度圈都是26高
    button.setBackgroundImage(.imageWithColor(color), forState: .Highlighted)
    return button
}
