//
//  Copyright (c) 2015年 NY. All rights reserved.
//

class User: BaseUser {
    var likes: [Like] = [] // 手动补
    var votes: [Vote] = [] // 手动补
    var tags: NSString = ""
    
    override class func getMapping() -> [String : String] {
        var dict = super.getMapping()
        dict["taqs"] = "tags"
        return dict
    }
}
