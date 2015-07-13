//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class Item: NSObject {
    var title = ""
    var segue = ""
    
    init(title: String, dest: UIViewController.Type? = nil, segue: String = "") {
        self.title = title
        if segue != "" {
            self.segue = segue
        } else {
            if dest != nil {
                var s = NSStringFromClass(dest).componentsSeparatedByString(".").last!.lowercaseString
                if s.rangeOfString("list") != nil {
                    s = s.stringByReplacingOccurrencesOfString("list", withString: "_list")
                } else if s.rangeOfString("detail") != nil {
                    s = s.stringByReplacingOccurrencesOfString("detail", withString: "_detail")
                }
                self.segue = s
            }
        }
    }
    
    class func emptyItem() -> Item {
        return Item(title: "")
    }
}
