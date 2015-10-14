//
//  Copyright (c) 2015 NY. All rights reserved.
//

class User: BaseUser {
    var likes: [Like] = [] // 手动补
    var votes: [Vote] = [] // 手动补
    var tags = ""
    var type = ""
    var company: Company?
    
    override class func getMapping() -> [String : String] {
        var dict = super.getMapping()
        dict["taqs"] = "tags"
        dict["type"] = "type"
        return dict
    }
}
